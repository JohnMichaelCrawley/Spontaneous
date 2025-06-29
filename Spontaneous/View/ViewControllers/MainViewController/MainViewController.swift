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
class MainViewController: UIViewController, CLLocationManagerDelegate, MainViewModelDelegate
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
        mainViewModel.delegate = self
        configureLocationManagerSetup()
        configureGoogleMapsMapView()
        configureBeSpontaneousButton()
#if targetEnvironment(simulator)
        print("Running on a simulator")
#else
        print("Running on an actual device")
#endif
        
        
        
        
    //    print("User Coords: \()")
        
        
        
        print("here lies the operation")
        let placeId = "ChIJN1t_tDeuEmsRUsoyG83frY4" // Google HQ in Dublin
        let urlStr = "https://maps.googleapis.com/maps/api/place/details/json?place_id=\(placeId)&key=\(GoogleAPIManager().returnAPIKey())"
               guard let url = URL(string: urlStr) else { return }

               let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                   if let error = error {
                       print("Error: \(error)")
                       return
                   }
                   guard let data = data else { return }
                   do {
                       if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                          let result = json["result"] as? [String: Any] {
                           if let name = result["name"] as? String, let address = result["formatted_address"] as? String {
                               print("Name: \(name)")
                               print("Address: \(address)")
                           }
                       }
                   } catch let error {
                       print("Error parsing JSON: \(error)")
                   }
               }
               task.resume()
           
    
        
        
        
        
        

    }
    // MARK: - Override View Did Load (Remove the top navigation bar from returning from get directions child view
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated) // Hide navigation bar in MainViewController
    }
}
