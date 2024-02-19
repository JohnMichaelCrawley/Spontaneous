/*
 Project:           Spontaneous
 File:              GetDirectionsViewControllerConfigure.swift
 Created:           01/02/2024
 Author:            John Michael Crawley
 
 Description:
 This file configures elements on the get directions view controller
 both configuring the labels and Google Maps
 */
//MARK: - Import list
import UIKit
import GoogleMaps
//MARK: - Get Directions View Controller Extension - Configure
extension GetDirectionsViewController
{
    //MARK: - Configure Top Navigation Bar
    func configureTopNavigationBar()
    {
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        // Add bottom border color
        let bottomBorderLayer = CALayer()
        bottomBorderLayer.backgroundColor = customColour.returnDefaultCGColour() // Change to your desired color
        bottomBorderLayer.frame = CGRect(x: 0, y: navigationController?.navigationBar.frame.height ?? 0 - 1, width: navigationController?.navigationBar.frame.width ?? 0, height: 1)
        navigationController?.navigationBar.layer.addSublayer(bottomBorderLayer)
    }
    //MARK: - Configure Google Maps Directions Display
    func configureGoogleMapsDirectionsDisplay()
    {
        //let LOCATION = "53.293838223653765, -6.134797540594663"
        // 53.28658464073151 / -6.145390955248935           tokyo
        //   let user =
        // let use = UserCoordinates.
        let LOCATION = UserCoordinatesManager.shared.getUserCoordinates()!
        let camera = GMSCameraPosition.camera(withLatitude: LOCATION.latitude , longitude:  LOCATION.longitude , zoom: 17.0)
        mapView = GMSMapView.map(withFrame: self.view.frame, camera: camera)
        // Configure Google Map shared instance
        GoogleMapManager.shared.initializeMap(on: mapView)
        GoogleMapManager.shared.setMapStyle()
        view.addSubview(mapView)
        configureGetDirectionsGoogleMapsConstraints()
        // Animate the map to the new camera position
        mapView.animate(to: camera)
        // Disable the rotate gesture
   //     mapView.settings.rotateGestures = false
    }
    //MARK: - Configure Destination
    func configureDestinationIcon()
    {
        if directionMarker == nil
        {
            let directionCoordinates = CLLocationCoordinate2D(latitude: place.latitude, longitude: place.longitude)
            directionMarker = GMSMarker(position: directionCoordinates)
            // Create a symbol configuration with desired size
            let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: 40)
            // Create a UIImage with the system icon and apply the symbol configuration
            guard let originalMarkerImage = UIImage(systemName: "flag.checkered")?.withConfiguration(symbolConfiguration) else { return }
            // Create a new image with the desired color
            guard let whiteMarkerImage = originalMarkerImage.imageWithColour(colour: .white) else { return }
            directionMarker?.icon = whiteMarkerImage
            directionMarker?.map = mapView
        }
        else
        {
          // else direction marker is not nil
        }
    }
  
}
