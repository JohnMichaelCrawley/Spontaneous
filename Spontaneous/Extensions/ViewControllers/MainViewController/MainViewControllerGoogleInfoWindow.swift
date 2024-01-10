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
    
    /* handles Info Window tap */
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
      //  print("didTapInfoWindowOf")
    }
    
    /* handles Info Window long press */
    func mapView(_ mapView: GMSMapView, didLongPressInfoWindowOf marker: GMSMarker) {
       // print("didLongPressInfoWindowOf")
    }

    
    //MARK: - Marker Info Window
    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView?
    {
        // Get the custom info window
        guard let infoWindow = Bundle.main.loadNibNamed("GoogleInfoWindowView", owner: self, options: nil)?.first as? GoogleInfoWindowView else {
            print("Unable to load GoogleInfoWindow")
            return nil
        }
        // Select random place from collection
        let place = mainViewModel.getRandomPlace()
        //var isOpen = place?.isOpenNow
        // Setup the info window data
        infoWindow.placeName = place?.name
        infoWindow.placeRating = "Rating: \(place!.rating)"
        //  infoWindow.placeIsOpen = place.isOpenNow
        infoWindow.placeType = "Types: \(place!.types)"
        // Button target
        infoWindow.getDirectionsButton.addTarget(self, action: #selector(getDirectionsToRandomlySelectedPlace), for: .touchUpInside)
        // Corner Radius
        infoWindow.layer.cornerRadius = 10
        // Border
        infoWindow.layer.borderWidth = 0.5
        infoWindow.layer.borderColor = UIColor.lightGray.cgColor
        
        
        // Return Info Window
        return infoWindow
    }
    // MARK: - Get Directions To Randomly Selected Place
    @objc func getDirectionsToRandomlySelectedPlace()
    {
        #if DEBUG
            print("get directions button pressed")
        #endif
    }
    //MARK: - Did Tap
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        return false}
}
