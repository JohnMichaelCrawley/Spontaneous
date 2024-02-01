/*
 Project:           Spontaneous
 File:              MainViewControllerGoogleInfoWindow.swift
 Created:           17/10/2023
 Author:            John Michael Crawley
 
 Description:
 This file configures the info window when displaying information
 to the user. This sets the info window to the custom window view
 I have made called, 'GoogleInfoWindowView'
 */
//MARK: - Import list
import GoogleMaps

//MARK: - Main View Controller Extension - GMS Map View Delegate
extension MainViewController : GMSMapViewDelegate
{
    //MARK: - Did Tap Window Of
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker)
    {
        //  print("didTapInfoWindowOf")
    }
    //MARK: - Did Long Press Info Window Of
    func mapView(_ mapView: GMSMapView, didLongPressInfoWindowOf marker: GMSMarker)
    {
        // print("didLongPressInfoWindowOf")
    }
    // This method is called when the map is tapped.
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D)
    {
        // Prevent the info window from closing when tapping off the marker
        mapView.selectedMarker = marker
    }
    //MARK: - Marker Info Window
    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView?
    {
        // Create the custom info window once
        guard let customInfoWindow = customInfoWindow(), let place = marker.userData as? Place else {return nil}
        // Setup the info window data
        customInfoWindow.placeName = place.name
        customInfoWindow.placeRating = "Rating: \(place.rating)"
        customInfoWindow.placeType = "Type/s: \(place.types)".replacingOccurrences(of: "[", with: "").replacingOccurrences(of: "]", with: "").replacingOccurrences(of: "\"", with: "")
        // Set the custom view UI data and constraints
        configureCustomView()
        configureGetDirectionsButton()
        getDirectionsButton!.alpha = 0.0 // set alpha to 0 which allows it to fade in
        // Fade in the button
        getDirectionsButton!.fadeIn()
        // Add customView as a subview to mapView
        mapView.addSubview(customView!)
        mapView.addSubview(getDirectionsButton!)
        // Add target for button tap
        getDirectionsButton!.addTarget(self, action: #selector(getDirectionsToRandomlySelectedPlace), for: .touchUpInside)
        // Info Window Corner Radius
        customInfoWindow.layer.cornerRadius = 10
        // Border
        customInfoWindow.layer.borderWidth = 0.5
        customInfoWindow.layer.borderColor = UIColor.lightGray.cgColor
        // Return Info Window
        return customInfoWindow
    }
    // MARK: - Get Directions To Randomly Selected Place
    @objc func getDirectionsToRandomlySelectedPlace()
    {
        #if DEBUG
       // print("Preparing to display a randomly selected place ....")
        print("-")
        print("place = \(place.name)")
        print("-")
      //  print("add = \()")
        #endif
    }
    //MARK: - Did Tap
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool { return false }
}
