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
    @IBOutlet var mapView: GMSMapView!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var walkingTimeLabel: UILabel!
    @IBOutlet weak var startRouteButton: UIButton!
    // Check if the button is tapped for the route//
    var isButtonPressed = false
    // USER DEFAULTS
    let USERDEFAULTS = UserDefaults.standard
    // Location
    var locationManager = CLLocationManager()           // LocationManager: Get the user's location
    // Theme Manager
    let themeManager = ThemeManager()
    // Route Variables
    // Google Client
    let client = GoogleMapsClient(apiKey: API().returnAPIKey())
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Hide the tab view controller in this view controller
        self.tabBarController?.tabBar.isHidden = true
        // Set the title of this view controller
        self.title = "\(USERDEFAULTS.string(forKey: "placeName") ?? "ERROR")"
        // Location - Set up delegate, update and accuracy
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        locationManager.desiredAccuracy = .greatestFiniteMagnitude
        // Notification Center Observer for the theme of the map
        NotificationCenter.default.addObserver(self, selector: #selector(updateMapTheme), name: .mapThemeDidChange, object: nil)
        // Set up the map view settings
      //  mapView.settings.compassButton = true
      //  mapView.settings.rotateGestures = true
        // Create markers for user and destination markers
        let originMarker = GMSMarker()
        let destinationMarker = GMSMarker()
        // Set the position for the markers
        originMarker.position = CLLocationCoordinate2D(latitude: getOriginLocation().latitude, longitude: getOriginLocation().longitude)
        destinationMarker.position = CLLocationCoordinate2D(latitude: getDestinationLocation().latitude, longitude: getDestinationLocation().longitude)
        // Set up the titles for the markers
        originMarker.title = "Origin"
        destinationMarker.title = "Destination"
        // Plot the marker on the map
        destinationMarker.map = mapView
        originMarker.map = mapView
        // Set the map route on the GMS Map View
        self.setMapRoute(originLocation: getOriginLocation(), destinationLocation: getDestinationLocation())
        //  startRouteJourney()
        endRouteJourney()
        // Set up the theme of the view controller
        let theme = USERDEFAULTS.string(forKey: "applicationTheme") ?? ""
        themeManager.setEntireApplicatonTheme(theme: theme, mapView: mapView)
        
        
        
        print("*******************************")
        
        print("Origin: ", getOriginLocation())
        print("Destination: ", getDestinationLocation())
        print("*******************************")
    }
    /*
     Update Map Style:
     This function sets the map in either dark mode
     or keep it in the default style of light mode.
     */
    @objc func updateMapStyle(_ notification: NSNotification)
    {
        let theme = UserDefaults.standard.string(forKey: "applicationTheme")
        themeManager.setEntireApplicatonTheme(theme: theme!, mapView: mapView)
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
      
        //let userLocation: CLLocationCoordinate2D = (CLLocationCoordinate2D(latitude: locationManager.location?.coordinate.latitude ?? 0.0, longitude: locationManager.location?.coordinate.longitude ?? 0.0))
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
     */
    @objc func updateMapTheme()
    {
        let theme = UserDefaults.standard.string(forKey: "applicationTheme")!
        themeManager.setEntireApplicatonTheme(theme: theme, mapView: mapView)
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
        // Create the route on the Map View & Append Polyline to Map
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
            distanceLabel.text = "Distance: \(getDistance()) miles"
            walkingTimeLabel.text = getWalkingDistance()
    }
    
    
    /*
     Function - Get Distance:
     This function calculates the distance
     from the origin (user's location) to the destination (place).
     This is calculated by getting the distance then
     calcuate the distance from meters to miles
     and return the value as a String value.
     */
    func getDistance() -> Double
    {
        let FROM = CLLocationCoordinate2D(latitude: getOriginLocation().latitude, longitude: getOriginLocation().longitude)
        let TO = CLLocationCoordinate2D(latitude: getDestinationLocation().latitude, longitude: getDestinationLocation().longitude)
        let distance = GMSGeometryDistance(FROM, TO)
        let distanceInMiles = distance / 1609.344 // Convert distance from meters to miles
        return output
    }
    /*
     Function - get Walking Distance:
     This function gets the distance from the origin (user's location)
     and the destination (place) and calculates the distance then
     
     calculates the distance it would take to
     */
    func getWalkingDistance() -> String
    {
        var output = ""
        let distanceInMiles = getDistance()
        let walkingSpeedInMetersPerMinute = 1.2
        let minutes = distanceInMiles / (walkingSpeedInMetersPerMinute * 0.000621371) / 60
        let returnLastTwoDecimals = String(format: "%.2f", minutes)
        if minutes > 1.0
        { output = "Walking Time: \(returnLastTwoDecimals) minutes" }
        else
        {output = "Walking Time: \(returnLastTwoDecimals) seconds" }
        // Return output
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
        { startRouteJourney() }
        else
        { endRouteJourney() }
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
              //  let path = route.polyline.path

                // Assuming you have already created a GMSMapView and added a GMSPolyline to it
                /*
                 In Swift 5 and Google Map API, how do I get the map view camera to face the current direction the polyline is facing?
                 */
                if let path = route.polyline.path, path.count() > 1
                {
                    let firstCoordinate = path.coordinate(at: 0)
                    let secondCoordinate = path.coordinate(at: 1)
                    
                    let heading = GMSGeometryHeading(firstCoordinate, secondCoordinate)
                    let fancy = GMSCameraPosition(
                        latitude: self.getOriginLocation().latitude,
                        longitude: self.getOriginLocation().longitude,
                        zoom: 40,
                        bearing: heading,
                        viewingAngle: 180
                    )
                    self.mapView.animate(to: fancy)
                    /*
                     Code below should remove the polyline
                     */
                    // Create a GMSPolyline object and add it to the map
                    let polylinePath = GMSMutablePath()
                    // As the user moves along the path, clear the previous polyline and draw a new one
                    func updatePathWithNewLocation(location: CLLocation) {
                        polylinePath.add(location.coordinate)
                        route.polyline.path = path
                    }
                    // To clear the polyline
                    route.polyline.map = nil
                    
                }
            }
     
        #if DEBUG
        print("After map update")
        #endif
    }
    
    /*
     End Route Journey:
     End the route and reset to the window before
     the start route where the user ends t
     */
    func endRouteJourney()
    {
        #if DEBUG
        print("tapped up")
        #endif
        startRouteButton.setTitle("Start Route", for: .normal)
        startRouteButton.backgroundColor = .link
        startRouteButton.tintColor = .link
        //set back
        let userLocation: CLLocationCoordinate2D = (CLLocationCoordinate2D(latitude: getOriginLocation().latitude, longitude: getOriginLocation().longitude))
       
        let destinationLocation: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: USERDEFAULTS.double(forKey: "placeLatitude"), longitude: USERDEFAULTS.double(forKey: "placeLongitude"))
        self.setMapRoute(originLocation: userLocation, destinationLocation: destinationLocation)
    }

    
}
