/*
 Project:           Spontaneous
 File:              MainViewControllerConfigure.swift
 Created:           04/09/2023
 Author:            John Michael Crawley
 
 Description:
 This file configures elements on the main view controller
 both configuring the button and Google Maps
 */
//MARK: - Import list
import UIKit
import GoogleMaps
//MARK: - Main View Controller Extension - Configure
extension MainViewController
{
    //MARK: - Configure Be Spontaneous Button
    func configureBeSpontaneousButton()
    {
        // Create and configure the main button
        beSpontaneousButton = UIButton(type: .roundedRect)
        beSpontaneousButton.backgroundColor = .systemBackground
        beSpontaneousButton.setTitleColor(customColour.returnDefaultUIColour(), for: .normal)
        beSpontaneousButton.setTitle("Be Spontaneous", for: .normal)
        beSpontaneousButton.layer.cornerRadius = 15
        beSpontaneousButton.layer.borderWidth = 0.55
        beSpontaneousButton.layer.borderColor = customColour.returnDefaultCGColour()
        beSpontaneousButton.addTarget(self, action: #selector(beSpontaneousButtonPressed), for: .touchUpInside)
        view.addSubview(beSpontaneousButton)
        configureBeSpontaneousButtonConstraints()
    }
    //MARK: - Configure Google Maps Mapview
    func configureGoogleMapsMapView()
    {
        let camera = GMSCameraPosition.camera(withLatitude: UserCoordinatesManager.shared.getUserCoordinates()?.latitude ?? 0.0, longitude: UserCoordinatesManager.shared.getUserCoordinates()?.longitude ?? 0.0, zoom: 15.0)
        mapView = GMSMapView.map(withFrame: self.view.frame, camera: camera)
        // Configure Google Map shared instance
        GoogleMapManager.shared.initializeMap(on: mapView)
        GoogleMapManager.shared.setMapStyle()
        view.addSubview(mapView)
        configureGoogleMapsConstraints()
        configureGoogleMapCameraPositionToUserLocation()
        mapView.delegate = self
    }
    //MARK: - Configure Custom View
    func configureCustomView()
    {
        if customView == nil
        {
            customView = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 100))
            //   customView?.backgroundColor = UIColor.blue
            // Enable user interaction on the UIView
            customView?.isUserInteractionEnabled = true
            // Calculate the position relative to the mapView
            let anchorPoint = mapView.projection.point(for: marker.position)
            let xOffset = anchorPoint.x - customView!.frame.width / 2
            let yOffset = anchorPoint.y - customView!.frame.height
            // Convert anchorPoint to mapView's coordinate space
            let mapViewPoint = mapView.convert(CGPoint(x: xOffset, y: yOffset), to: mapView)
            // Set the frame based on the converted point with decreased top value
            customView!.frame = CGRect(x: mapViewPoint.x, y: mapViewPoint.y - customView!.frame.height - 20, width: 300, height: 100)
            // Ensure that getDirectionsButton is configured before adding it
            configureGetDirectionsButton()
            // Add custom view and get directions button to the map view
            mapView.addSubview(customView!)
            mapView.addSubview(getDirectionsButton!)
            // Set up constraints for Get Directions button
            configureGetDirectionsConstraints()
        }
    }
    //MARK: - Configure Get Directions Button
    func configureGetDirectionsButton() 
    {
        // Check if getDirectionsButton is nil
        if getDirectionsButton == nil 
        {
            getDirectionsButton = UIButton(type: .roundedRect)
            getDirectionsButton!.setTitle("Get directions", for: .normal)
            getDirectionsButton!.setTitleColor(customColour.returnDefaultUIColour(), for: .normal)
            getDirectionsButton!.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
            getDirectionsButton!.backgroundColor = .systemBackground
            getDirectionsButton!.layer.cornerRadius = 10
            getDirectionsButton!.layer.borderWidth = 2
            getDirectionsButton!.layer.borderColor = customColour.returnSecondaryCGColour()
            getDirectionsButton!.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    //MARK: - Google Info Window
    func customInfoWindow() -> GoogleInfoWindowView?
    {
        // Get the custom info window
        guard let infoWindow = Bundle.main.loadNibNamed("GoogleInfoWindowView", owner: self, options: nil)?.first as? GoogleInfoWindowView else 
        {
            #if DEBUG
            print("Unable to load GoogleInfoWindow")
            #endif
            return nil
        }
        return infoWindow
    }
}
