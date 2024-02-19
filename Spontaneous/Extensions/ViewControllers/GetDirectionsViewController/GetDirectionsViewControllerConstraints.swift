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
//MARK: - Get Directions View Controller Extension - Constraints
extension GetDirectionsViewController
{    
    //MARK: - Configure Google Maps Mapview Constraints
    func configureGetDirectionsGoogleMapsConstraints()
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
}
