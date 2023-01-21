//
//  ViewController.swift
//  Spontaneous
//
//  Created by John Michael Crawley on 12/12/2022.
//
/*
 INFORMATION ON THIS CLASS / FILE:
 This file is the used for the main
 View Controller for displaying Google Maps,
 button for the user have the ability to find something
 random to do the local area. This class / file gets
 and stores information on the business it gets from Google
 */

/*
 UI tools for GoogleMap API
 https://developers.google.com/maps/documentation/navigation/ios-sdk/controls
 https://developers.google.com/maps/documentation/ios-sdk/configure-map
 */
// IMPORT LIST
import UIKit
import GoogleMaps
import GooglePlaces
import CoreLocation
class ViewController: UIViewController, CLLocationManagerDelegate
{
    /* TEST VARIABLES */
    var isToggleActive = false
    /* VARIABLES */
    @IBOutlet weak var mapView: GMSMapView!             // U.I: Display Google Map's //
    var locationManager = CLLocationManager()           // LocationManager: Get information on coordinates from the user etc //
    let USERDEFAULTS = UserDefaults.standard            // USERDEFAULTS: used to access stored data i.e settings //
    var business = Business()                           // Get the business data structs etc from Business file //
    // GOOGLE MAPS
    let marker = GMSMarker()                            // Google Maps Marker (Pop up)
    // JSON
    let JSONDECODER = JSONDecoder()                     // JSON DECODER
    /*
     User and Business location:
     Store the business lat' and long' to be used
     to center the camera to
     */
    var businessLocation = CLLocationCoordinate2D(latitude: 0.0,longitude: 0.0)
    var userLocation = CLLocationCoordinate2D(latitude: 0.0,longitude: 0.0)
    var businessLatitude: Double =  0.0
    var businessLongitude: Double = 0.0
    var userLatitude: Double = 0.0
    var userLongitude: Double = 0.0
    
    /*
     View Did Load:
     This func is called when loading a view controller
     hierarchy into memory.
     */
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        /*
         Location Manager set up:
         Location manager delegate is set to self
         and enable the start updating location and desired accuracy
         to enable the use of the location manager and get the user's
         location (lat' and long') to be used in Google's API
         to get a business near the user
         */
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        locationManager.desiredAccuracy = .greatestFiniteMagnitude
        /*
         When the application loads up, the application will
         request the user to enable the location for the application's
         function to work properly.
         */
        DispatchQueue.global().async
        {
            if CLLocationManager.locationServicesEnabled()
            {
                self.locationManager.requestLocation()
            }
            else
            {
                self.locationManager.requestWhenInUseAuthorization()
            }
        }
     
        updateMapStyle()
        
        /*
         MAP VIEW SETTINGS:
         Include or adjust the mapView properties
         */
        mapView.isMyLocationEnabled = true  // SHOWS BLUE DOT FOR USER'S LOCATION
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
            displayDialogAlert(title: "Map Style Error:", message: "One or more of the map styles failed to load. \(error)")
        }
    }
    
    
    
    
    
    
    
    
    /*
     Did Update Locations:
     This function checks for updates in the
     update of the location. It contains a
     function that checks both business and
     user's locations. It checks if the business
     has values for lat' and long' but if it doesn't
     it'll load the camera on the user's location.
     */
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        setBusinessLocation(businessLocation: businessLocation, userLocation: userLocation)
    }
    /*
     Check Authorisation:
     this code checks which authorisation
     the application has to get the user's location
     in the application
     */
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager)
    {
        switch locationManager.authorizationStatus
        {
        case .authorizedAlways:
            #if DEBUG
            print("Authorised always")
            #endif
            return
        case .authorizedWhenInUse:
            #if DEBUG
            print("Authorised when in use")
            #endif
            return
        case .denied:
            #if DEBUG
            print("denied")
            #endif
            return
        case .restricted:
            #if DEBUG
            print("restrictd")
            #endif
            locationManager.requestWhenInUseAuthorization()
        case .notDetermined:
            #if DEBUG
            print("not determined")
            #endif
            locationManager.requestWhenInUseAuthorization()
        default:
            #if DEBUG
            print("Default")
            #endif
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    // DID FAIL WITH ERROR? THEN PRINT ERROR TO LOG //
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        #if DEBUG
        print(error)
        #endif
    }
    /*
     Be Spontaneous Pressed:
     This function is called to get, pick and display
     data on a random business in the user's local area
     and display them in a marker
     */
    @IBAction func beSpontaneousPressed(_ sender: Any)
    {
        /*
         USER DEFINED VARIABLES:
         Include variables for:
         - user's lat' + long'
         - radius set by the user
         - selected keywords (business type)
         */
        // TEST COORDINATES - USED FOR TESTING PURPOSES
        let userLatitude = 53.347568
        let userLongitude = -6.259353
        // USER COORDINATES
       // let userLatitude = locationManager.location?.coordinate.latitude ?? 0.0
       // let userLongitude = locationManager.location?.coordinate.longitude ?? 0.0
        #if DEBUG
       // print("User's LAT:", userLatitude)
       // print("User's LNG:", userLongitude)
        #endif
        
        // RADIUS
        let RADIUS = USERDEFAULTS.float(forKey: "searchRadiusFilter")
       // let RADIUS = 0.0
        /*
         SEARCH DEFINED VARIABLES:
         Includes variables for:
         - keyword (business type)
         - URL (URL to search for business in Google's API)
         - marker (used to add an information window
         */
        
        let KEYWORD = business.getRandomLocation().lowercased()
        //let KEYWORD = "cafe"
        #if DEBUG
        print("The keyword selected for the search is:", KEYWORD)
        #endif
        
        
        // let KEYWORD = "cafe"
       // print("VC Keyword:", KEYWORD.uppercased())
        let url = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=\(userLatitude),\(userLongitude)&radius=\(RADIUS)&type=\(KEYWORD)&key=\(API().returnAPIKey())";
        URLSession.shared.dataTask(with: URL(string: url)! ,completionHandler:
        { data, task, error in
            guard let data = data, error == nil else
            {
                #if DEBUG
                print("Something went wrong wih getting the data!...")
                #endif
                return
            }
            /*
             Try to decode the JSON for the business
             data and store it as an object as part of
             the business class
             */
            do
            {
                // Get access to the JSON data
                self.JSONDECODER.keyDecodingStrategy = .convertFromSnakeCase
                let root = try self.JSONDECODER.decode(Root.self, from: data)
                // Get random i
                // Get random number from a range of amount of results in JSON
                let range = root.results.count
                var index = 0
                if range >= 1
                {
                    index = Int.random(in: 1..<range)
                    if index >= 1
                    {
                        // Set data to the business model
                        self.business.setBusinessID(ID: root.results[index].placeId)
                        self.business.setBusinessName(name: root.results[index].name)
                        self.business.setBusinessType(type: root.results[index].types)
                        self.business.setBusinessOpeningHours(openingHours: root.results[index].openingHours ?? [:])
                        self.business.setBusinessAddress(vicinity: root.results[index].vicinity)
                        self.business.setBusinessRating(rating: root.results[index].rating)
                        self.business.setBusinessLatitude(lat: root.results[index].geometry.location.lat)
                        self.business.setBusinessLongitude(lng: root.results[index].geometry.location.lng)
                    }
                    else
                    {
                        #if DEBUG
                     //   print("index is equal to 0")
                        #endif
                    }
                }
                else if index == 0 || range == 0
                {
                    #if DEBUG
                   // print("Error on range")
                    #endif
                }
            }
            catch
            {
                #if DEBUG
                print(error)
                #endif
            }
        }).resume()
       
        // Set up display of information
        // Is Open
        // Check whether the business is open and if it is
        // return a string of, "Open Now" other wise, "Closed"
          let isOpen = business.getBusinessOpeningHours()
          var BusinessOpenOrClosed = ""
          switch isOpen
          {
          case ["open_now": true]:
              BusinessOpenOrClosed = "Open Now"
          case ["open_now": false]:
              BusinessOpenOrClosed = "Closed"
          default:
              BusinessOpenOrClosed = "Closed"
          }

        // SET MARKER UP
        //  Is Opened?:\(b.getBusinessOpeningHours()) \n
        marker.title = business.getBusinessName()
        marker.snippet =
        """
        \(BusinessOpenOrClosed)
        Type/s: \(business.getBusinessType())
        Rating:\(business.getBusinessRating())
        """
        /*
         Store the business lat' and long' to be used
         to center the camera to
         */
        // let businessLatitude =  business.getBusinessLat()
        // let businessLongitude =  business.getBusinessLong()
        businessLatitude = business.getBusinessLat()
        businessLongitude =  business.getBusinessLong()
        businessLocation = CLLocationCoordinate2D(latitude: businessLatitude,longitude: businessLongitude)
        userLocation = CLLocationCoordinate2D(latitude: userLatitude,longitude: userLongitude)
    
        

        
        /*
         TESTING PURPOSES:
         This creates a circle around the user's location
         and this allows me to make sure places found is
         within the search radius.
         */
        
        /*
        let circle = GMSCircle()
        circle.map = nil
        circle.radius = 0
        circle.radius = CLLocationDistance(RADIUS) // Meters
        circle.fillColor = UIColor.red
        circle.position = userLocation // Your CLLocationCoordinate2D  position
        circle.strokeWidth = 2.5;
        circle.strokeColor = UIColor.black
        circle.map = mapView; // Add it to the map
        */
        
    
        
        // Check buisness and user location and set camera
        setBusinessLocation(businessLocation: businessLocation, userLocation: userLocation)
        
        #if DEBUG
        if business.getBusinessLat() == 0 && business.getBusinessLong() == 0
        {
            print("business coordinates are 0")
        }
        else
        {
            print("business has coordinates")
        }
        #endif
        
        
        if businessLatitude != 0 && businessLongitude != 0
        {
            marker.position = businessLocation
            marker.map = mapView
            mapView.selectedMarker = marker
            marker.position = businessLocation
        }
        else
        {
            displayDialogAlert(title: "No Locations Found:", message: "Nothing was found in the search. Please adjust search filters / location and try again.")
        }
        
    }
    /*
     TESTING PURPOSES BUTTON:
     This button will show or remove the circle
     radius on the map.THIS MUST BE DELETED IN
     PRODUCTION
     */
    @IBAction func toggleRadiusButton(_ sender: UIButton)
    {
        let RADIUS = USERDEFAULTS.float(forKey: "searchRadiusFilter")
        var circle = GMSCircle()
        
        isToggleActive = !isToggleActive
        // TRUE = TOGGLE ON
        if isToggleActive
        {
            circle.map = nil
            circle.radius = 0
            circle.radius = CLLocationDistance(RADIUS) // Meters
            circle.fillColor = UIColor.red
            circle.position = userLocation // Your CLLocationCoordinate2D  position
            circle.strokeWidth = 2.5;
            circle.strokeColor = UIColor.black
            circle.map = mapView; // Add it to the map
        }
        // FALSE
        else
        {
            circle.map = nil
            mapView.clear()
            marker.map = mapView
        }
    }
    
  

    
    
    /*
     Set Business Location:
     This function is used to set the location of the
     camera. It stores the business and user's lat and lng
     values and has a latitude and longitude for use to set the
     camera position.It then checks the business lat and lng, if
     doesn't have values, it will set the latitude and longitude
     to the user's location, if it has values then it goes to the
     business location.
     */
    func setBusinessLocation(businessLocation: CLLocationCoordinate2D, userLocation: CLLocationCoordinate2D )
    {
        // Business
        let businessLatitude = businessLocation.latitude
        let businessLongitude = businessLocation.longitude
        // User
        let userLatitude = userLocation.latitude
        let userLongitude = userLocation.longitude
        // Camera settings
        let zoom:Float = 14.0
        var latitude = 0.0
        var longitude = 0.0
        if businessLocation.longitude == 0.0 && businessLocation.latitude == 0.0
        {
            latitude = userLatitude
            longitude = userLongitude
        }
        else
        {
            latitude = businessLatitude
            longitude = businessLongitude
        }

        let camera: GMSCameraPosition = GMSCameraPosition.camera(withLatitude:latitude, longitude: longitude, zoom: zoom)
        let center = CLLocationCoordinate2D(latitude: latitude,longitude: longitude)
        self.mapView.animate(to: camera)
    }
}
/*
 This extension has a function that
 displays a dialog alert to display
 to the user. This is D.R.Y code
 (Don't Repeat Yourself) meaning
 it's reusable rather than write
 the same code over and over.
 */
extension UIViewController
{
    func displayDialogAlert(title: String, message: String)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}


