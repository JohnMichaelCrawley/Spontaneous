//
//  ViewController.swift
//  Spontaneous
//
//  Created by John Michael Crawley on 12/12/2022.
//

/*
 UI tools for GoogleMap API
 https://developers.google.com/maps/documentation/navigation/ios-sdk/controls
 https://developers.google.com/maps/documentation/ios-sdk/configure-map
 */


import UIKit
import GoogleMaps
import GooglePlaces
import CoreLocation



class ViewController: UIViewController, CLLocationManagerDelegate
{
    /* VARIABLES */
    @IBOutlet weak var mapView: GMSMapView!             // U.I: Display Google Map's //
    var locationManager = CLLocationManager()           // LocationManager: //
    let USERDEFAULTS = UserDefaults.standard
    
    
    /*
     View Did Load
     */
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // API
        
        locationManager.delegate = self
        
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
        
        
        locationManager.desiredAccuracy = .greatestFiniteMagnitude
        
        // MAP VIEW SETTINGS
        // mapView.settings.myLocationButton = true
        mapView.settings.compassButton = true
        
        
    }
    
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        mapView.camera = GMSCameraPosition(target: CLLocationCoordinate2D(latitude:  locationManager.location?.coordinate.latitude ?? 0.0, longitude:  locationManager.location?.coordinate.longitude ?? 0.0), zoom: 10, bearing: 0, viewingAngle: 0)
        
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
            print("Authorised always")
            return
        case .authorizedWhenInUse:
            print("Authorised when in use")
            return
        case .denied:
            print("denied")
            return
        case .restricted:
            print("restrictd")
            locationManager.requestWhenInUseAuthorization()
        case .notDetermined:
            print("not determined")
            locationManager.requestWhenInUseAuthorization()
        default:
            print("Default")
            locationManager.requestWhenInUseAuthorization()
        }
        
        
        // print("location Manager Did Change Authorization: Got here")
        //print("Longittude = ", locationManager.location?.coordinate.longitude)
        // print("Latitude = ", locationManager.location?.coordinate.latitude)
        
        
    }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print(error)
    }
    
    
    
    /*
     Be Spontaneous Pressed:
     this function is called when the
     button is pressed
     */
    
    var b = Business()
    
    
    @IBAction func beSpontaneousPressed(_ sender: Any)
    {
        // Ask user to confirm location
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        // VAIRABLES FOR SEARCH
        // USER DEF
        var lat = 53.347568
        var long = -6.259353
        var radius = 620
        // SEARCH DEF
        let KEYWORD = "cafe"
        let url = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=\(lat),\(long)&radius=\(radius)&type=\(KEYWORD)&key=\(API().returnAPIKey())";
        // Google Maps Marker
        let marker = GMSMarker()
        // JSON DECODER
        let JSONDECODER = JSONDecoder()
        
        
        URLSession.shared.dataTask(with: URL(string: url)! ,completionHandler:
        { data, task, error in
            guard let data = data, error == nil else
            {
                print("Something went wrong wih getting the data!...")
                return
            }
            
            do
            {
                // Get access to the JSON data
                JSONDECODER.keyDecodingStrategy = .convertFromSnakeCase
                let root = try JSONDECODER.decode(Root.self, from: data)
                // Get random i
                // Get random number from a range of amount of results in JSON
                let range = root.results.count
                var index = 0
                index = Int.random(in: 1..<range)
                if index > 1
                {
                    // Set data to the business model
                    self.b.setBusinessID(ID: root.results[index].placeId)
                    self.b.setBusinessName(name: root.results[index].name)
                    self.b.setBusinessType(type: root.results[index].types)
                //    self.b.setBusinessOpeningHours(openingHours: root.results[index].openingHours!)
                    self.b.setBusinessAddress(vicinity: root.results[index].vicinity)
                    self.b.setBusinessRating(rating: root.results[index].rating)
                    self.b.setBusinessLatitude(lat: root.results[index].geometry.location.lat)
                    self.b.setBusinessLongitude(lng: root.results[index].geometry.location.lng)
                }
                else
                {
                    print("index is equal to 0")
                }

                
            }
            catch{print(error)}
            
        }).resume()
       
        
        // SET MARKER UP
        //  Is Opened?:\(b.getBusinessOpeningHours()) \n
        marker.title = b.getBusinessName()
        marker.snippet = """
         Type/s: \(b.getBusinessType()) \n
        Rating:\(b.getBusinessRating()) \n
        """
    
        //marker.snippet = "\(description) was found with a rating of \(review), the radius it was found in is a radius of \(r) miles"
        marker.map = mapView
        mapView.selectedMarker = marker
        
        print("""
              NAME=\(b.getBusinessName())\n
              LAT=\(b.getBusinessLat())\n
              LNG=\(b.getBusinessLong())
              """)
        
        
        // zoom = 15
        let blat =  b.getBusinessLat()
        let blong =  b.getBusinessLong()
        
        let center = CLLocationCoordinate2D(
            latitude: blat,
            longitude: blong
        )
        marker.position = center
        
        
        let camera: GMSCameraPosition = GMSCameraPosition.camera(withLatitude:blat, longitude: blong, zoom: 14)
        self.mapView.animate(to: camera)
        
        
        
        
        
        
        
    }
    
}
