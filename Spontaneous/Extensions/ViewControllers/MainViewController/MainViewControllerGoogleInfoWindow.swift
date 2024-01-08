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
        print("didTapInfoWindowOf")
    }
    
    /* handles Info Window long press */
    func mapView(_ mapView: GMSMapView, didLongPressInfoWindowOf marker: GMSMarker) {
        print("didLongPressInfoWindowOf")
    }

    
    
    //MARK: - Marker Info Window
    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView?
    {
        let infoWindow = Bundle.main.loadNibNamed("GoogleInfoWindow", owner: self, options: nil)?.first as! GoogleInfoWindowView
              // SET UP VARIABLES
           
              // Types output

              // Set data to info window
        //      infoWindow.placeNameLabel.text = "\(name)"
          //    infoWindow.placeRatingLabel.text = "Rating: \(rating)"
          //    infoWindow.placeTypesLabel.text = "Type: \n\(typesOutput)"
          //    infoWindow.placeOpenHoursLabel.text = "\(openHours)"
        
        
        
        
        infoWindow.placeName = "BOB"
              // Corner Radius
              infoWindow.layer.cornerRadius = 10
              // Border
              infoWindow.layer.borderWidth = 0.5
              infoWindow.layer.borderColor = UIColor.lightGray.cgColor
        
        
        
        infoWindow.configureNIB()
              // Return Info Window
              return infoWindow
        
     //   let view = Bundle.main.loadNibNamed("GoogleInfoWindow", owner: self, options: nil)?.first as! GoogleInfoWindowView
      //  let frame = CGRect(x: 10, y: 10, width: 200, height: view.frame.height)
      //  view.frame = frame
      //  return view
    }
    
    
    
    
    
    
    
    //MARK: - Did Tap
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool { return false}


}
