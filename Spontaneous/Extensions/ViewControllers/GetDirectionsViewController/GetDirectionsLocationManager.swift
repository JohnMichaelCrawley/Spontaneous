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
    /*
     When inside the Get Directions view the update locations function will
     will get the current location of the user and set the icon of the user from
     SF Symbols (called, "location.north.circle.fill") and disable the blue dot icon
     then follow the user's location with the updated icon to show the directions like
     Google Maps / Apple Maps navigation.
     */
    // Track user's location, replace blue dot with arrow
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        guard let location = locations.last else { return }
        
        // Update marker position
        if userMarker == nil
        {
            userMarker = GMSMarker(position: location.coordinate)
            // Create a symbol configuration with desired size
            let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: 120)
            // Create a UIImage with the system icon and apply the symbol configuration
            guard let originalMarkerImage = UIImage(systemName: "location.north.circle.fill")?.withConfiguration(symbolConfiguration) else { return }
            
           // userMarker?.icon = originalMarkerImage
            userMarker?.map = mapView

            // userMarker?.icon..rotation = 45.0 // Rotate the marker icon by 45 degrees
        } else {
            userMarker?.position = location.coordinate
          //  rotateMarker(userMarker, degrees: 45.0) // Rotate marker by 45 degrees
        }
    }
    
    func rotateMarker(_ marker: GMSMarker?, degrees: CLLocationDegrees)
    {
        guard let marker = marker else { return }
        
        // Apply rotation transform to the marker
        marker.rotation = degrees
    }
    
    




    
    
    
    
    
    
    
    
    
    
    
    //MARK: - locationManagerDidChangeAuthorization
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager)
    {
        // Handle authorization changes, if needed
    }
}
