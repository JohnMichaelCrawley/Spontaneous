//
//  GetDirectionsLocationManager.swift
//  Spontaneous
//
//  Created by John Crawley on 06/02/2024.
//

// MARK: - Import List
import Foundation
import CoreLocation
import GoogleMaps
//MARK: - Get Directions View Controller - Location Manager Extension
extension GetDirectionsViewController
{
    // MARK: -  did update locations:
    // Track user's location, replace blue dot with arrow
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        guard let location = locations.last else { return }
        // Update marker position
        if userMarker == nil
        {
            userMarker = GMSMarker(position: location.coordinate)
            // Create a symbol configuration with desired size
            let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: 70)
            // Create a UIImage with the system icon and apply the symbol configuration
            guard let originalMarkerImage = UIImage(systemName: "location.north.circle.fill")?.withConfiguration(symbolConfiguration) else { return }
            // Create a new image with the desired color
            guard let whiteMarkerImage = originalMarkerImage.imageWithColour(colour: .white) else { return }
            userMarker?.icon = whiteMarkerImage
            userMarker?.map = mapView
            mapView.isMyLocationEnabled = false // turns off blue dot
        }
        else
        {
            userMarker?.position = location.coordinate
        }
        // Move camera to user's location
        mapView.animate(toLocation: location.coordinate)
    }
    //MARK: - locationManagerDidChangeAuthorization
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager)
    {
        // Handle authorization changes, if needed
    }
}
