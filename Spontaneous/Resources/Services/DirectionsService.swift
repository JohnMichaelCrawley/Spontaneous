//
//  DirectionsService.swift
//  Spontaneous
//
//  Created by John Crawley on 02/07/2025.
//

import Foundation
import CoreLocation

class DirectionsService
{
    
    
    
    
    
    
    func fetchWalkingDirections(from origin: CLLocationCoordinate2D,
                                to destination: CLLocationCoordinate2D,
                                apiKey: String,
                                completion: @escaping (Result<([DirectionsStep], String, String, String), Error>) -> Void)
    {

        let originStr = "\(origin.latitude),\(origin.longitude)"
        let destinationStr = "\(destination.latitude),\(destination.longitude)"

        let urlString = "https://maps.googleapis.com/maps/api/directions/json?origin=\(originStr)&destination=\(destinationStr)&mode=walking&key=\(apiKey)"
        #if DEBUG
        print("[DEBUG] Requesting directions from URL: \(urlString)")
        #endif

        guard let url = URL(string: urlString)
        else
        {
            #if DEBUG
            print("[DEBUG] Invalid URL")
            #endif
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error
            {
                #if DEBUG
                print("[DEBUG] Network error: \(error.localizedDescription)")
                #endif
                completion(.failure(error))
                return
            }

            guard let data = data else
            {
                #if DEBUG
                print("[DEBUG] No data returned from Google Directions API")
                #endif
                return
            }

            do
            {
                guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                      let routes = json["routes"] as? [[String: Any]],
                      let firstRoute = routes.first,
                      let legs = firstRoute["legs"] as? [[String: Any]],
                      let firstLeg = legs.first,
                      let duration = firstLeg["duration"] as? [String: Any],
                      let eta = duration["text"] as? String,
                      let distance = firstLeg["distance"] as? [String: Any],
                      let distText = distance["text"] as? String,
                      let stepsJson = firstLeg["steps"] as? [[String: Any]],
                      let overview = firstRoute["overview_polyline"] as? [String: Any],
                      let polyline = overview["points"] as? String
                else
                {
                    #if DEBUG
                    print("[DEBUG] Failed to parse directions JSON")
                    #endif
                    return
                }

                // Extract step-by-step instructions
                let steps: [DirectionsStep] = stepsJson.compactMap { stepDict in
                    guard
                        let instruction = stepDict["html_instructions"] as? String,
                        let distanceDict = stepDict["distance"] as? [String: Any],
                        let distanceText = distanceDict["text"] as? String,
                        let startLocDict = stepDict["start_location"] as? [String: Any],
                        let lat = startLocDict["lat"] as? CLLocationDegrees,
                        let lng = startLocDict["lng"] as? CLLocationDegrees
                    else {
                        return nil
                    }

                
                    var cleanedInstruction = instruction
                    if let data = instruction.data(using: .utf8),
                       let attributed = try? NSAttributedString(
                           data: data,
                           options: [
                               .documentType: NSAttributedString.DocumentType.html,
                               .characterEncoding: String.Encoding.utf8.rawValue
                           ],
                           documentAttributes: nil
                       ) {
                        cleanedInstruction = attributed.string
                    }

                    let coord = CLLocationCoordinate2D(latitude: lat, longitude: lng)
                    return DirectionsStep(instruction: cleanedInstruction, distance: distanceText, startLocation: coord)
                }


                #if DEBUG
                print("[DEBUG] Parsed \(steps.count) steps, ETA: \(eta), Distance: \(distText), Polyline: \(polyline.prefix(30))...")
                #endif
                
                completion(.success((steps, polyline, eta, distText)))
            }
            catch
            {
                    #if DEBUG
                print("[DEBUG] Failed to decode JSON: \(error)")
                #endif
                completion(.failure(error))
            }
        }.resume()
    }

    
    
    
    
    
    
    
    
    
}
