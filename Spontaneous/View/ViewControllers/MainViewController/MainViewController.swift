/*
 Project:           Spontaneous
 File:              MainViewController.swift
 Created:           23/08/2023
 Author:            John Michael Crawley
 
 Description:
 This is the main view of the application where
 the user first lands. This view controller displays
 Google Maps on the screen
 */
//MARK: - Import list
import UIKit
import GoogleMaps
import CoreLocation
//Mark: - Main View Controller
class MainViewController: UIViewController, CLLocationManagerDelegate
{
    //MARK: - Variables
    var mainViewModel = MainViewModel()
    let customColour = CustomColours()              // Custom Colours
    let locationManager = CLLocationManager()       // Location Manager to get user location
    //MARK: - User Interface variables
    var beSpontaneousButton: UIButton!              // Button to get spontaneous items
    var mapView: GMSMapView!                        // Google Maps
    var marker = GMSMarker()                        // Google Marker
    var customView: UIView?                         //  custom view for UI Button
    var getDirectionsButton: UIButton?              // Button to open directions window
    //MARK: - Variables
    override func viewDidLoad()
    {
        super.viewDidLoad()
        configureLocationManagerSetup()
        configureGoogleMapsMapView()
        configureBeSpontaneousButton()
        
        #if targetEnvironment(simulator)
            print("Running on a simulator")
        #else
            print("Running on an actual device")
        #endif
    }
    // MARK: - Override View Did Load (Remove the top navigation bar from returning from get directions child view
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated) // Hide navigation bar in MainViewController
    }

}
