/*
 Project:           Spontaneous
 File:              MainViewControllerConstraints.swift
 Created:           06/09/2023
 Author:            John Michael Crawley
 
 Description:
 This file adds constraints to the user interface elements
 on the main view controller
 */
//MARK: - Import list
import UIKit
import GoogleMaps
//MARK: - Main View Controller Extension - Constraints
extension MainViewController
{    
    //MARK: - Configure Be Spontaneous Button Constraints
    func configureBeSpontaneousButtonConstraints()
    {
        // Set up Auto Layout constraints
        beSpontaneousButton.translatesAutoresizingMaskIntoConstraints = false
        beSpontaneousButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        beSpontaneousButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        beSpontaneousButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        beSpontaneousButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
    //MARK: - Configure Google Maps Mapview Constraints
    func configureGoogleMapsConstraints()
    {
        mapView.translatesAutoresizingMaskIntoConstraints = false
        // Create constraints to make the mapView fill the entire parent view
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    //MARK: - Get Directions Button Constraints
    func configureGetDirectionsConstraints()
    {
        // Check if customView is not nil
        guard let customView = customView, let getDirectionsButton = getDirectionsButton else {return}
        // Set button constraints relative to the customView with increased width
        NSLayoutConstraint.activate([
            getDirectionsButton.centerXAnchor.constraint(equalTo: customView.centerXAnchor),
            getDirectionsButton.topAnchor.constraint(equalTo: customView.bottomAnchor, constant: 10),
            getDirectionsButton.widthAnchor.constraint(equalToConstant: 250),       // Adjust the width
            getDirectionsButton.heightAnchor.constraint(equalToConstant: 60)        // Adjust the height
        ])
    }
    
}
