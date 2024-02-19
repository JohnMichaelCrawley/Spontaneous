/*
 Project:           Spontaneous
 File:              MainViewControllerLocationManager.swift
 Created:           13/10/2023
 Author:            John Michael Crawley
 
 Description:
 This file handles all the location data for Google Maps
 and the user. This file handles the selection of option
 the user selects for allowing the app' to know the user's
 location.
*/
//MARK: - Imports
import Foundation
import GoogleMaps
import CoreLocation
//MARK: - Main View Controller - Extension - Location Manager
extension MainViewController
{
    //MARK: - Configure Location Manager Setup
    func configureLocationManagerSetup()
    {
        // Request permission to access the user's location
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        locationManager.desiredAccuracy = .greatestFiniteMagnitude
        /*
         When the application loads up, the application will
         request the user to enable the location for the application's
         function to work properly.
         */
        DispatchQueue.global().async
        {
            if CLLocationManager.locationServicesEnabled()
            {self.locationManager.requestLocation()}
            else
            {self.locationManager.requestWhenInUseAuthorization()}
        }
    }
    //MARK: - Did Update Locations
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        // Keep the camera on the user until a place is found then focus on the place
        guard let location = locations.last else { return }
        let place = PlacesManager.shared.returnSinglePlace() // Using nil coalescing operator to handle nil case
        // if the returned place name isn't empty
        if !PlacesManager.shared.returnSinglePlace().name.isEmpty
        {
            // If a place is available, set the camera position to focus on the place
            let placeCoordinate = CLLocationCoordinate2D(latitude: place.latitude, longitude: place.longitude)
          //  configureGoogleMapCameraPositionToPlace(placeCoordinate)
        }
        else
        {
            UserCoordinatesManager.shared.setUserCoordinates(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            configureGoogleMapCameraPositionToUserLocation()
        }
    }
    // MARK: - Location Manager - Did Change Auth'
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus)
    {
        switch status 
        {
        case .authorizedWhenInUse, .authorizedAlways:
            #if DEBUG
            print("auth in use")
           /*
            print("""
                    Lat = \(locationManager.location?.coordinate.latitude ?? 0.0)
                    Long = \(locationManager.location?.coordinate.longitude ?? 0.0)
                    """)
            */
            #endif
            
        
    
            UserCoordinatesManager.shared.setUserCoordinates(latitude: locationManager.location?.coordinate.latitude ?? 0.0,
                                                             longitude: locationManager.location?.coordinate.longitude ?? 0.0)
            configureGoogleMapCameraPositionToUserLocation()
           // configureGoogleMapCameraPositionToUserLocation()
        case .denied, .restricted:
            #if DEBUG
            print("denied / rest")
            #endif
            // Location services are disabled or restricted.
            // Handle this case, e.g., show an alert to the user.
        case .notDetermined:
            #if DEBUG
            print("unknown")
            #endif
            configureGoogleMapCameraPositionToUserLocation()
            // The user has not made a choice yet.
            // You can request authorization here if needed.
        default:
            break
        }
    }
    //MARK: - Did Fail With Error
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        #if DEBUG
        print(error)
        #endif
    }
    //MARK: - Configure Google Map Camera Position To User Location
    func configureGoogleMapCameraPositionToUserLocation()
    {
        let location = UserCoordinatesManager.shared.getUserCoordinates()
     //   let zoom = GoogleMapManager.shared.returnZoomLevelBasedOnRadiusValue()
        if let latitude = location?.latitude,
           let longitude = location?.longitude
        {
            let camera = GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude, zoom: 15)
            // Animate the map to the new camera position
            mapView.animate(to: camera)
            
          //  print(zoom)
        }
        else
        {
            // Handle the case where location is nil or doesn't contain valid coordinates
            // You may want to show an alert or take some appropriate action.
        }
        
    }
}
