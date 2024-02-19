/*
 Project:           Spontaneous
 File:              GetDirectionsViewController.swift
 Created:           01/02/2024
 Author:            John Michael Crawley
 
 Description:
 This view controller handles the map view
 and the directions to the selected place
 by the application.
 */
//Import List
import UIKit
import GoogleMaps
import CoreLocation
//MARK: - Get Directions View Controller
class GetDirectionsViewController: UIViewController, CLLocationManagerDelegate, UINavigationControllerDelegate
{
    //MARK: - Variables
    let place = PlacesManager.shared.returnSinglePlace()
    let customColour = CustomColours()              // Custom Colours
    let locationManager = CLLocationManager()       // Location Manager to get user location
    //MARK: - User Interface variables
    var mapView: GMSMapView!                        // Google Maps
    // Markers for the user and the destination icons
    var userMarker: GMSMarker?
    var directionMarker: GMSMarker?
    // MARK: - View Did Load
    override func viewDidLoad() 
    {
          super.viewDidLoad()
          self.title = "\(place.name) directions"
          configureGoogleMapsDirectionsDisplay()
          configureDestinationIcon()
          // Configure the location manager
          locationManager.delegate = self
          locationManager.requestWhenInUseAuthorization()
          locationManager.startUpdatingLocation()
      }
    // MARK: - View Will Appear
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated) // Show navigation bar in GetDirectionsViewController
        // Style the navigation bar
        configureTopNavigationBar()
    }
}

