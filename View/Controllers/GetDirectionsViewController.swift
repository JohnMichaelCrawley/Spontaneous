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
  //  let userLocation: CLLocation
    // let userLocation = locationManager.location.coordinate
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Hide the tab view controller in this view controller
        self.tabBarController?.tabBar.isHidden = true
        //   self.GetDirectionsViewController?.tabBar.hidden = true
        let TITLE = USERDEFAULTS.string(forKey: "placeName") ?? "ERROR"
        self.title = "\(TITLE)"
        // Update the map style based on user selection //
        updateMapStyle()
        // Location
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        locationManager.desiredAccuracy = .greatestFiniteMagnitude
        mapView.isMyLocationEnabled = true  // SHOWS BLUE DOT FOR USER'S LOCATION
        // Set up camera to the map
        let userLocation: CLLocationCoordinate2D = (CLLocationCoordinate2D(latitude: locationManager.location?.coordinate.latitude ?? 0.0, longitude: locationManager.location?.coordinate.longitude ?? 0.0))
        let destinationLocation: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: USERDEFAULTS.double(forKey: "placeLatitude"), longitude: USERDEFAULTS.double(forKey: "placeLongitude"))
        // GoogleMapDirectionsLocation(latitude: USERDEFAULTS.double(forKey: "placeLatitude") ?? 0.0 , longitude: USERDEFAULTS.double(forKey: "placeLongitude") ?? 0.0)
        
        setMapRoute(originLocation: userLocation, destinationLocation: destinationLocation)

        
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
    /*
     Get Directions Route:
     Get the directions route
     and post it on the map
     */
    func getDirectionsRoute()
    {
        let userLocation = locationManager.location?.coordinate
        let origin = GoogleMapDirectionsLocation(latitude: userLocation?.latitude ?? 0.0, longitude: userLocation?.longitude ?? 0.0)
        let destination = GoogleMapDirectionsLocation(latitude: USERDEFAULTS.double(forKey: "placeLatitude") , longitude: USERDEFAULTS.double(forKey: "placeLongitude"))
        let client = GoogleMapsClient(apiKey: API().returnAPIKey())
        client.getRoute(from: origin, to: destination) { route in
          guard let route = route else {
            return
          }
            route.polyline.map = self.mapView
        }
    }
    /*
     Set Route:
     Set the bounds of the camera view
     based on the origin and destination
     location on the map view
     */
    func setMapRoute(originLocation: CLLocationCoordinate2D, destinationLocation: CLLocationCoordinate2D)
    {
        //zoom the map to show the desired area
        var bounds = GMSCoordinateBounds()
        bounds = bounds.includingCoordinate(originLocation)
        bounds = bounds.includingCoordinate(destinationLocation)
        self.mapView.moveCamera(GMSCameraUpdate.fit(bounds))
        //finally get the route
        getDirectionsRoute()
    }
}
