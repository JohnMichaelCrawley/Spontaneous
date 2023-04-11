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
    // MARK: - Variables
    @IBOutlet var mapView: GMSMapView!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var walkingTimeLabel: UILabel!
    @IBOutlet weak var startRouteButton: UIButton!
    // Check if the button is tapped for the route//
    private var isButtonPressed = false
    // USER DEFAULTS
    private let USERDEFAULTS = UserDefaults.standard
    // Location
    private var locationManager = CLLocationManager()
    // Theme Manager
    private let themeManager = ThemeManager()
    // Route Variables
    // Google Client
    private var polyline: GMSPolyline?
    private let client = GoogleMapsClient(apiKey: API().returnAPIKey())
    // Marker
    // Destination marker Icon
    private let sfFlagSymbolImage = UIImage(systemName: "flag.checkered")

    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Hide the tab view controller in this view controller
        self.tabBarController?.tabBar.isHidden = true
        // Set the title of this view controller
        self.title = "\(USERDEFAULTS.string(forKey: "placeName") ?? "ERROR")"
        // Location - Set up delegate, update and accuracy
        // Set up the location manager
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        // Notification Center Observer for the theme of the map
        NotificationCenter.default.addObserver(self, selector: #selector(updateMapTheme), name: .mapThemeDidChange, object: nil)
        // Set up the map view settings
        mapView.isMyLocationEnabled = true
      //  mapView.settings.compassButton = true
      //  mapView.settings.rotateGestures = true
        // Create markers for user and destination markers
     //   let originMarker = GMSMarker()
        let destinationMarker = GMSMarker()
        // Set the position for the markers
      //  originMarker.position = CLLocationCoordinate2D(latitude: getOriginLocation().latitude, longitude: getOriginLocation().longitude)
        destinationMarker.position = CLLocationCoordinate2D(latitude: getDestinationLocation().latitude, longitude: getDestinationLocation().longitude)
        // Set up the titles for the markers
      //  originMarker.title = "Origin"
        destinationMarker.title = "Destination"
        let flagIconImageView = UIImageView(image: sfFlagSymbolImage)
        flagIconImageView.tintColor = UIColor.systemCyan
        // Set the flag icon image width and height
        flagIconImageView.frame = CGRectMake( flagIconImageView.frame.origin.x,flagIconImageView.frame.origin.y, 60, 60);
        // set the image to the icon marker
        destinationMarker.iconView = flagIconImageView
        // Plot the marker on the map
        destinationMarker.map = mapView
        mapView.selectedMarker = destinationMarker
      //  originMarker.map = mapView
        // Set the map route on the GMS Map View
        self.setMapRoute(originLocation: getOriginLocation(), destinationLocation: getDestinationLocation())
        //  startRouteJourney()
        endRouteJourney()
        // Set up the theme of the view controller
        let theme = USERDEFAULTS.string(forKey: "applicationTheme") ?? ""
        themeManager.setEntireApplicatonTheme(theme: theme, mapView: mapView)
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
    //MARK: Get Origin (User) and Destination location funcs
    /*
     Get Origin Location + Get Destination Location:
     these two functions return the origin (user's location)
     and destination (place the user selected). These
     return a CL Location Coordinate 2D
     */
    func getOriginLocation() -> CLLocationCoordinate2D
    {
      //  let userLocation: CLLocationCoordinate2D = (CLLocationCoordinate2D(latitude: 53.347568, longitude: -6.259353))
      
        let userLocation: CLLocationCoordinate2D = (CLLocationCoordinate2D(latitude: locationManager.location?.coordinate.latitude ?? 0.0, longitude: locationManager.location?.coordinate.longitude ?? 0.0))
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
    //MARK: Calcuate distance and time for journey
    /*
     Function - Get Distance:
     This function calculates the distance
     from the origin (user's location) to the destination (place).
     This is calculated by getting the distance then
     calcuate the distance from meters to miles
     Get the last two decimal points from a String
     then covert it back to a Double
     */
    func getDistance() -> Double
    {
        let FROM = CLLocationCoordinate2D(latitude: getOriginLocation().latitude, longitude: getOriginLocation().longitude)
        let TO = CLLocationCoordinate2D(latitude: getDestinationLocation().latitude, longitude: getDestinationLocation().longitude)
        let distance = GMSGeometryDistance(FROM, TO)
        let distanceInMiles = distance / 1609.344 // Convert distance from meters to miles
        let formattedDistance = String(format: "%.2f", distanceInMiles)
        return Double(formattedDistance) ?? 0.0
    }
    /*
     Function - get Walking Distance:
     This function gets the distance from the origin (user's location)
     and the destination (place) and calculates the distance then
     calculates the distance it would take to walk the route
     */
    func getWalkingDistance() -> String
    {
        var output = ""
        let distanceInMiles = getDistance()
        let walkingSpeedInMetersPerMinute = 1.2
        let seconds = ( distanceInMiles / (walkingSpeedInMetersPerMinute * 0.000621371) )
        let minutes = Int(seconds / 60)
        let remaningSeconds = Int(seconds.truncatingRemainder(dividingBy: 60))
        if minutes > 1
        { output = "Walking Time: \(minutes) minutes, \(remaningSeconds) seconds"}
        else {output = "Walking Time: \(remaningSeconds) seconds" }
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
        {startRouteJourney()}
        else
        {endRouteJourney()}
    }
    //MARK: - Start and End Journey Functions
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
        
        let origin = GoogleMapDirectionsLocation(latitude: self.locationManager.location?.coordinate.latitude ?? 0.0, longitude: self.locationManager.location?.coordinate.longitude ?? 0.0)
        let destination = GoogleMapDirectionsLocation(latitude: getDestinationLocation().latitude, longitude:getDestinationLocation().longitude)
            client.getRoute(from: origin, to: destination)
            {
                route in guard let route = route else {return}
    
                // Setting visuals up for polylines
                route.polyline.strokeWidth = 7
                route.polyline.strokeColor = UIColor.cyan
                // show route
                route.polyline.map = self.mapView
                // Add route polyline to polyline variable
                self.polyline = route.polyline
                // Assuming you have already created a GMSMapView and added a GMSPolyline to it
                /*
                 In Swift 5 and Google Map API, how do I get the map view camera to face the current direction the polyline is facing?
                 */
                if let path = route.polyline.path, path.count() > 1
                {
                    self.setCameraPosition(path: path)
                    /*
                     Code below should remove the polyline
                     */
                    // Create a GMSPolyline object and add it to the map
                    let polylinePath = GMSMutablePath()
                    // As the user moves along the path, clear the previous polyline and draw a new one
                    func updatePathWithNewLocation(location: CLLocation)
                    {
                        polylinePath.add(location.coordinate)
                        route.polyline.path = path
                        self.polyline?.path = path // assign path to polyline
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
    /*
     Set Camera Position:
     This function sets the camera to the
     user's location
     */
    func setCameraPosition(path: GMSPath)
    {
        let firstCoordinate = path.coordinate(at: 0)
        let secondCoordinate = path.coordinate(at: 1)
        let heading = GMSGeometryHeading(firstCoordinate, secondCoordinate)
        let fancy = GMSCameraPosition(
            latitude: self.locationManager.location?.coordinate.latitude ?? 0.0,
            longitude: self.locationManager.location?.coordinate.longitude ?? 0.0,
            zoom: 40,
            bearing: heading,
            viewingAngle: 180
        )
        self.mapView.animate(to: fancy)
    }
    /*
     Function - did Update Locations:
     This function keeps track of the user's location.
     The code written inside checks if the route is begun
     (if isButtonPressed = true means the route is started and
     user is going to the destination). If this is true it will
     start the route by setting the camera to be fixed on the user
     and removing the polyline as the user traverses to the destination.
     */
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        let newMutablePath = GMSMutablePath()           // New path for GMS-Polyline
        let thresholdDistance: CLLocationDistance = 10  //  Set a threshold distance for adding points to the new path
        if let location = locations.last
        {
            // If the route has begun
            if isButtonPressed == true
            {
                let origin = GoogleMapDirectionsLocation(latitude: self.locationManager.location?.coordinate.latitude ?? 0.0, longitude: self.locationManager.location?.coordinate.longitude ?? 0.0)
                let destination = GoogleMapDirectionsLocation(latitude: getDestinationLocation().latitude, longitude:getDestinationLocation().longitude)
                client.getRoute(from: origin, to: destination)
                {
                    route in guard let route = route else {return}
                    // Setting visuals up for polylines
                    if let path = route.polyline.path, path.count() > 1
                    {
                        self.setCameraPosition(path: path)
                        // POLYLINE
                        // Loop through each point on the original polyline
                        for i in 0..<path.count()
                        {
                            // Get the coordinate of the point on the original polyline
                            let coordinate = path.coordinate(at: i)
                            // Calculate the distance between the user's location and the point on the original polyline
                            let distance = GMSGeometryDistance(coordinate, location.coordinate)
                            // If the distance is less than the threshold distance, add the point to the new path
                            if distance < thresholdDistance
                            {
                                newMutablePath.add(coordinate)
                            }
                        }
                    }
                }
            }
        }
    }
    /*
     Function - did Change Authorization:
     Check if the user changed the authorization
     status.
     */
       func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
           // Handle changes to the user's location authorization status
           switch status {
           case .authorizedWhenInUse, .authorizedAlways:
               locationManager.startUpdatingLocation()
           default:
               locationManager.stopUpdatingLocation()
           }
       }
}
