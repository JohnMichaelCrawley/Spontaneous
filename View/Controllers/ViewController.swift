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
        
        /*
         MAP VIEW SETTINGS:
         Include or adjust the mapView properties
         */
        mapView.isMyLocationEnabled = true  // SHOWS BLUE DOT FOR USER'S LOCATION
    }
    

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
       // mapView.camera = GMSCameraPosition(target: CLLocationCoordinate2D(latitude:  locationManager.location?.coordinate.latitude ?? 0.0, longitude:  locationManager.location?.coordinate.longitude ?? 0.0), zoom: 10, bearing: 0, viewingAngle: 0)
        
       // let marker = GMSMarker()
      //  marker.position = CLLocationCoordinate2D(latitude: locationManager.location?.coordinate.latitude ?? 0.0, longitude: locationManager.location?.coordinate.longitude ?? 0.0)
        
        /*marker.title = "Title"
         marker.snippet = "Here"
         marker.icon = UIImage(named: "house")
         marker.map = mapView*/
        
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
       // let userLatitude = 53.347568
       // let userLongitude = -6.259353
        // USER COORDINATES
        let userLatitude = locationManager.location?.coordinate.latitude ?? 0.0
        let userLongitude = locationManager.location?.coordinate.longitude ?? 0.0
        // RADIUS
        let RADIUS = USERDEFAULTS.float(forKey: "searchRadiusFilter")
        /*
         SEARCH DEFINED VARIABLES:
         Includes variables for:
         - keyword (business type)
         - URL (URL to search for business in Google's API)
         - marker (used to add an information window
         */
        let KEYWORD = "cafe"
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
                    if index > 1
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
                        print("index is equal to 0")
                        #endif
                    }
                }
                else
                {
                    #if DEBUG
                    print("Error on range")
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
        \(BusinessOpenOrClosed)\n
        Rating:\(business.getBusinessRating())\n
        """
    
        //marker.snippet = "\(description) was found with a rating of \(review), the radius it was found in is a radius of \(r) miles"
        marker.map = mapView
        mapView.selectedMarker = marker

        
        /*
         Store the business lat' and long' to be used
         to center the camera to
         */
        let businessLatitude =  business.getBusinessLat()
        let businessLongitude =  business.getBusinessLong()
        let center = CLLocationCoordinate2D(latitude: businessLatitude,longitude: businessLongitude)
        marker.position = center
        let camera: GMSCameraPosition = GMSCameraPosition.camera(withLatitude:businessLatitude, longitude: businessLongitude, zoom: 14)
        self.mapView.animate(to: camera)
    }
}
