//
//  GetDirectionsViewController.swift
//  Spontaneous
//
//  Created by John Michael Crawley on 10/02/2023.
//
/*
 INFORMATION ON THIS CLASS / FILE:
 This file is used to tell the user how to get
 to the location that was randomly choosen by
 the applications algorithm and show directions.
 */

// IMPORT LIST
import UIKit
import GoogleMaps
import GooglePlaces
import CoreLocation

class GetDirectionsViewController: UIViewController, CLLocationManagerDelegate
{
    // U.I variables
    @IBOutlet weak var mapView: GMSMapView!             // U.I: Display Google Map's //
    
    
    // USER DEFAULTS 
    let USERDEFAULTS = UserDefaults.standard            // USERDEFAULTS: used to access stored data i.e settings //
    // Location
    var locationManager = CLLocationManager()           // LocationManager: Get information on coordinates from the user etc //
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
     //   self.GetDirectionsViewController?.tabBar.hidden = true
        
        
        let TITLE = USERDEFAULTS.string(forKey: "placeName") ?? "ERROR"
        
        print(TITLE)
        
        self.title = "\(TITLE)"
        
        // Update the map style based on user selection //
        updateMapStyle()
        
        // Location
        
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        locationManager.desiredAccuracy = .greatestFiniteMagnitude
        mapView.isMyLocationEnabled = true  // SHOWS BLUE DOT FOR USER'S LOCATION

        
        
        
        let camera: GMSCameraPosition = GMSCameraPosition.camera(withLatitude:locationManager.location?.coordinate.latitude ?? 0.0, longitude: locationManager.location?.coordinate.longitude ?? 0.0, zoom: 15)
        
        let center = CLLocationCoordinate2D(latitude: locationManager.location?.coordinate.latitude ?? 0.0,longitude: locationManager.location?.coordinate.longitude ?? 0.0)
    
        self.mapView.animate(to: camera)
        
    }
    
    /*
     Update Map Style:
     This function sets the map in either dark mode
     or keep it in the default style of light mode.
     PROBLEM:
     When the user goes to change the theme, the map
     style doesn't refresh, this may because of the
     view controller not reloading.
     */
    func updateMapStyle()
    {
        do
        {
            let styleURL = Bundle.main.url(forResource: "style", withExtension: "json")
            let theme = USERDEFAULTS.string(forKey: "applicationTheme") ?? "light"
             
            if theme == "dark"
            {
                mapView.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL!)
                #if DEBUG
                print("Map View is in dark mode")
                #endif
            }
            if theme == "light"
            {
                mapView.mapStyle = .none
                #if DEBUG
                print("Map View is in light mode")
                #endif
            }
        }
        catch
        {
          //  displayDialogAlert(title: "Map Style Error:", message: "One or more of the map styles failed to load. \(error)")
        }
    }
    
    

    
    
    
    
    
    
    
    
    
    
    

    
    
    
}
