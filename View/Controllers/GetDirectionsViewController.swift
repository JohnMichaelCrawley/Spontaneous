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
    @IBOutlet var mapView: GMSMapView!             // U.I: Display Google Map's //
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var walkingTimeLabel: UILabel!
    @IBOutlet weak var startRouteButton: UIButton!
    
    // Check if the button is tapped for the route//
    var isButtonPressed = false
    // USER DEFAULTS
    let USERDEFAULTS = UserDefaults.standard            // USERDEFAULTS: used to access stored data i.e settings //
    // Location
    var locationManager = CLLocationManager()           // LocationManager: Get
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Update the map style based on user selection //
        NotificationCenter.default.addObserver(self, selector: #selector(self.updateMapTheme), name: .mapThemeDidChange, object: nil)
        // Hide the tab view controller in this view controller
        self.tabBarController?.tabBar.isHidden = true
        //   self.GetDirectionsViewController?.tabBar.hidden = true
        let TITLE = USERDEFAULTS.string(forKey: "placeName") ?? "ERROR"
        self.title = "\(TITLE)"
        // Location
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        locationManager.desiredAccuracy = .greatestFiniteMagnitude
        mapView.isMyLocationEnabled = true  // SHOWS BLUE DOT FOR USER'S LOCATION
        // Set up camera to the map
       // let userLocation: CLLocationCoordinate2D = (CLLocationCoordinate2D(latitude: locationManager.location?.coordinate.latitude ?? 0.0, longitude: locationManager.location?.coordinate.longitude ?? 0.0))
        // Add Markers
        let originMarker = GMSMarker()
        let destinationMarker = GMSMarker()
        // Set the marker positions
        originMarker.position = CLLocationCoordinate2D(latitude: getOriginLocation().latitude, longitude: getOriginLocation().longitude)
        originMarker.title = "Origin"
        destinationMarker.position = CLLocationCoordinate2D(latitude: getDestinationLocation().latitude, longitude: getDestinationLocation().longitude)
        destinationMarker.title = "Destination"
        // Plot the marker on the map
        destinationMarker.map = mapView
        originMarker.map = mapView
        // Set map route
        self.setMapRoute(originLocation: getOriginLocation(), destinationLocation: getDestinationLocation())
      //  startRouteJourney()
        endRouteJourney()
        
    }
    /*
     Get Origin Location + Get Destination Location:
     these two functions return the origin (user's location)
     and destination (place the user selected). These
     return a CL Location Coordinate 2D
     */
    func getOriginLocation() -> CLLocationCoordinate2D
    {
        let userLocation: CLLocationCoordinate2D = (CLLocationCoordinate2D(latitude: 53.347568, longitude: -6.259353))
        return userLocation
    }
    func getDestinationLocation() -> CLLocationCoordinate2D
    {
        
        let destinationLocation: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: USERDEFAULTS.double(forKey: "placeLatitude"), longitude: USERDEFAULTS.double(forKey: "placeLongitude"))
        return destinationLocation
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
    @objc func updateMapTheme()
    {

            let mapStyle = UserDefaults.standard.string(forKey: "applicationTheme")
            let styleURL = Bundle.main.url(forResource: "style", withExtension: "json")
            
            switch mapStyle
            {
            case "dark":
                self.mapView.mapStyle = try! GMSMapStyle(contentsOfFileURL: styleURL!)
                print("\n\nWOW dark mode enabled in directions")
            case "light":
                self.mapView.mapStyle = .none
                print("\n\nWOW light mode enabled in directions")
            default:
                self.mapView.mapStyle = .none
            }
    }
    /*
     Get Directions Route:
     Get the directions route
     and post it on the map
     
     */
    func getDirectionsRoute()
    {
        let origin = GoogleMapDirectionsLocation(latitude: getOriginLocation().latitude, longitude: getOriginLocation().longitude)
        let destination = GoogleMapDirectionsLocation(latitude: getDestinationLocation().latitude, longitude: getDestinationLocation().longitude)
        let userLocation = self.locationManager.location?.coordinate
        // let origin = GoogleMapDirectionsLocation(latitude: userLocation?.latitude ?? 0.0, longitude: userLocation?.longitude ?? 0.0)

        let client = GoogleMapsClient(apiKey: API().returnAPIKey())
            client.getRoute(from: origin, to: destination)
            {
                route in
                guard let route = route else {return}
                // Setting visuals up for polylines
                route.polyline.strokeWidth = 7
                route.polyline.strokeColor = UIColor.cyan
                // show route
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
            distanceLabel.text = getDistance()
            walkingTimeLabel.text = getWalkingDistance()
    }
    
    /*
     get the distance and output
     */
    func getDistance() -> String
    {
        
        let origin = GoogleMapDirectionsLocation(latitude: getOriginLocation().latitude, longitude: getOriginLocation().longitude)
        let destination = GoogleMapDirectionsLocation(latitude: getDestinationLocation().latitude, longitude:getDestinationLocation().longitude)
        
        let from = CLLocationCoordinate2D(latitude: origin.latitude, longitude: origin.longitude)
        let to = CLLocationCoordinate2D(latitude: destination.latitude, longitude: destination.longitude)
        
        let distance = GMSGeometryDistance(from, to)
        let distanceInMiles = distance / 1609.344 // Convert distance from meters to miles

        let returnLastTwoDecimals = String(format: "%.2f", distanceInMiles)
        let output = "Distance: \(returnLastTwoDecimals) miles"
        return output
    }
    
    
    func getWalkingDistance() -> String
    {
        let origin = GoogleMapDirectionsLocation(latitude: getOriginLocation().latitude, longitude: getOriginLocation().longitude)
        let destination = GoogleMapDirectionsLocation(latitude: getDestinationLocation().latitude, longitude:getDestinationLocation().longitude)
        
        
        let from = CLLocationCoordinate2D(latitude: origin.latitude, longitude: origin.longitude)
        let to = CLLocationCoordinate2D(latitude: destination.latitude, longitude: destination.longitude)
        
        
        let distance = GMSGeometryDistance(from, to)
        

        let walkingSpeedInMetersPerMinute = 80.0 // Replace with your walking speed in meters per minute

        let minutes = distance / walkingSpeedInMetersPerMinute
        
        
        let returnLastTwoDecimals = String(format: "%.2f", minutes)
        
        
        var output = ""
        if minutes > 1.0
        { output = "Walking Time: \(returnLastTwoDecimals) minutes" }
        else
        {output = "Walking Time: \(returnLastTwoDecimals) seconds" }
        
        

        
        return output
    }
    /*
     Start Route Button Pressed
     Check if the button is pressed and if pressed
     open up the route fully and if the user presses the button
     again then it will reset to the map view
     */
    @IBAction func startRouteButtonPressed(_ sender: Any)
    {
        
        isButtonPressed = !isButtonPressed
        
        if isButtonPressed
        {
            startRouteJourney()
        }
        else
        {
            endRouteJourney()
        }
         
    }
    /*
     Start Journey Route:
     Show the map closer and start updating the
     location and remove polyline as the user gets
     closer to the destination
     */
    func startRouteJourney()
    {
        // Set end button
        startRouteButton.setTitle("End Route", for: .normal)
        startRouteButton.backgroundColor = .red
        startRouteButton.tintColor = .red
        
        #if DEBUG
        print("Start Route tapped")
        #endif
        // Move camera to the user
        let origin = GoogleMapDirectionsLocation(latitude: getOriginLocation().latitude, longitude: getOriginLocation().longitude)
        let destination = GoogleMapDirectionsLocation(latitude: getDestinationLocation().latitude, longitude:getDestinationLocation().longitude)
       
        let client = GoogleMapsClient(apiKey: API().returnAPIKey())
            client.getRoute(from: origin, to: destination)
            {
                route in
                guard let route = route else {return}
                // Setting visuals up for polylines
                route.polyline.strokeWidth = 7
                route.polyline.strokeColor = UIColor.cyan
                // show route
                route.polyline.map = self.mapView
                
                // Set up bearings
                let path = route.polyline.path
                
                guard let startPoint = path?.coordinate(at: 0),
                        let endPoint = path?.coordinate(at: path!.count() - 1)
                else {
                    return
                }
                
                 let bearing = GMSGeometryHeading(startPoint, endPoint)

                 let fancy = GMSCameraPosition(
                    latitude: self.getOriginLocation().latitude,
                    longitude: self.getOriginLocation().longitude,
                   zoom: 40,
                   bearing: bearing,
                   viewingAngle: 180
                 )
                self.mapView.animate(to: fancy
                )
               // self.mapView.camera = fancy
            }
        #if DEBUG
        print("After map update")
        #endif
        
      //  self.mapView = GMSMapView(frame: self.view.bounds, camera: camera)
             
    }
    
    /*
     End Route Journey:
     End the route and reset to the window before
     the start route
     */
    func endRouteJourney()
    {
        print("tapped up")
        startRouteButton.setTitle("Start Route", for: .normal)
        startRouteButton.backgroundColor = .link
        startRouteButton.tintColor = .link
        //set back
        let userLocation: CLLocationCoordinate2D = (CLLocationCoordinate2D(latitude: 53.347568, longitude: -6.259353))
        let destinationLocation: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: USERDEFAULTS.double(forKey: "placeLatitude"), longitude: USERDEFAULTS.double(forKey: "placeLongitude"))
        self.setMapRoute(originLocation: userLocation, destinationLocation: destinationLocation)
    }
    
    

    
}
