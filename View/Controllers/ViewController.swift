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
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: locationManager.location?.coordinate.latitude ?? 0.0, longitude: locationManager.location?.coordinate.longitude ?? 0.0)
        
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
    @IBAction func beSpontaneousPressed(_ sender: Any)
    {
        locationManager.delegate = self
        
        locationManager.requestWhenInUseAuthorization()
        // print("Button was pressed!!!")
        
        
        
        //    let locationObject = locationManager.location!
        let latitude = (locationManager.location?.coordinate.latitude ?? 0.0)
        let longitude = (locationManager.location?.coordinate.longitude ?? 0.0)
    
        
        // SET / STORE LAT + LONG IN USER DEFAULTS
        USERDEFAULTS.set(latitude, forKey: "latitude")
        USERDEFAULTS.set(longitude, forKey: "longitude")
        
        
        
        
        // print("Longittude = ", latitude)
        //  print("Latitude = ", longitude)
        
        
        
        let center = CLLocationCoordinate2D(
            latitude: locationManager.location?.coordinate.latitude ?? 0.0 ,
            longitude: locationManager.location?.coordinate.longitude ?? 0.0
        )
        
        //USERDEFAULTS.value(forKey: "searchRadiusFilter"
        
        let marker = GMSMarker()
        marker.position = center
        
        
        
        
        // Get radius from USER DEFAULTS
        let r = (USERDEFAULTS.value(forKey: "searchRadiusFilter")) as! Float
        
        let review = "4/5 stars"
        let description = "this local business does x y and z stuff that is good for bam"
        
        
        
        marker.title = "Buisness Name"
        marker.snippet = "\(description) was found with a rating of \(review), the radius it was found in is a radius of \(r) miles"
        
        
        marker.map = mapView
        
        mapView.selectedMarker = marker
        
        
        let camera: GMSCameraPosition = GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude, zoom: 15)
        self.mapView.animate(to: camera)
        
        
        
        
        /*
         Attempt to scrape Google API businesses.
         Resources used to help:
         https://akshaydevkate.medium.com/scrape-data-from-google-maps-using-swift-and-google-maps-places-api-911e78c8908
         */
        
        /*
         
         
         let radius = 5000
         let search = "cafe"
         let file = "JSON"
         var resultsFound = 0
         
         
         
         let URL = "https://maps.googleapis.com/maps/api/place/nearbysearch/\(file)?location=\(latitude),\(longitude)&radius=\(radius)&type=\(search)&key=\(API().returnAPIKey())"
         */
    }
    
    
    
    
    
    private func getData(from url: String){
        URLSession.shared.dataTask(with: URL(string: url)! ,completionHandler: { data, task, error in
            guard let data = data, error == nil else {
                print("Something went wrong")
                return
            }})
     }
    
    
    
    
}
