//
//  DirectionsService.swift
//  Spontaneous
//
//  Created by John Crawley on 02/07/2025.
//

import Foundation
import CoreLocation

class DirectionsService {
    func fetchWalkingDirections(
        from origin: CLLocationCoordinate2D,
        to destination: CLLocationCoordinate2D,
        apiKey: String,
        completion: @escaping (Result<([DirectionsStep], String, String, String), Error>) -> Void)
    {
        let originStr = "\(origin.latitude),\(origin.longitude)"
        let destinationStr = "\(destination.latitude),\(destination.longitude)"
        let urlStr = "https://maps.googleapis.com/maps/api/directions/json?origin=\(originStr)&destination=\(destinationStr)&mode=walking&key=\(apiKey)"

        guard let url = URL(string: urlStr) else { return }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error)); return
            }

            guard let data = data,
                  let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                  let route = (json["routes"] as? [[String: Any]])?.first,
                  let leg = (route["legs"] as? [[String: Any]])?.first else {
                return
            }

            var steps: [DirectionsStep] = []
            if let rawSteps = leg["steps"] as? [[String: Any]] {
                for step in rawSteps {
                    guard let html = step["html_instructions"] as? String,
                          let distance = step["distance"] as? [String: Any],
                          let distText = distance["text"] as? String,
                          let startLoc = step["start_location"] as? [String: Any],
                          let lat = startLoc["lat"] as? CLLocationDegrees,
                          let lng = startLoc["lng"] as? CLLocationDegrees else { continue }

                    let stripped = html.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression)
                    steps.append(DirectionsStep(instruction: stripped, distance: distText, startLocation: CLLocationCoordinate2D(latitude: lat, longitude: lng)))
                }
            }

            let polyline = (route["overview_polyline"] as? [String: Any])?["points"] as? String ?? ""
            let totalETA = (leg["duration"] as? [String: Any])?["text"] as? String ?? ""
            let totalDist = (leg["distance"] as? [String: Any])?["text"] as? String ?? ""

            completion(.success((steps, polyline, totalETA, totalDist)))
        }.resume()
    }
}
