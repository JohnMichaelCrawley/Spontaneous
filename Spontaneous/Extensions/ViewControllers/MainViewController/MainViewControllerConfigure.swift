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
    }
    
}
