//
//  GoogleMapDirections.swift
//  Spontaneous
//
//  Created by John Michael Crawley on 13/02/2023.
//

import Foundation
import GoogleMaps
// MARK: - User's Location
struct GoogleMapDirectionsLocation
{
    let latitude: Double
    let longitude: Double
    var coordinate: CLLocationCoordinate2D
    {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
// MARK: - Route
struct MapRoute
{
    let path: GMSPath
    let polyline: GMSPolyline
    init(path: GMSPath)
    {
        self.path = path
        polyline = GMSPolyline(path: path)
    }
}
// MARK: - Google Map Client
struct GoogleMapsClient
{
    let apiKey: String
    func getRoute(from origin: GoogleMapDirectionsLocation, to destination: GoogleMapDirectionsLocation, completion: @escaping (MapRoute?) -> Void) {
        let originString = "\(origin.latitude),\(origin.longitude)"
        let destinationString = "\(destination.latitude),\(destination.longitude)"
        let request = "https://maps.googleapis.com/maps/api/directions/json?origin=\(originString)&destination=\(destinationString)&key=\(apiKey)"
        let task = URLSession.shared.dataTask(with: URL(string: request)!) { (data, response, error) in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            let json = try? JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
            guard let routes = json?["routes"] as? [[String: Any]],
                  let route = routes.first,
                  let polyline = route["overview_polyline"] as? [String: String],
                  let points = polyline["points"] else {
                completion(nil)
                return
            }
            let path = GMSPath(fromEncodedPath: points)

          //  polyline.strokeColor =
            
            let xroute = MapRoute(path: path!)
            completion(xroute)
        }
        task.resume()
    }
}
