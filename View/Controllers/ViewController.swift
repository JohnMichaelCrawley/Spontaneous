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


    
    /*
     View Did Load
     */
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // API
        
        locationManager.delegate = self
        
        if CLLocationManager.locationServicesEnabled()
        {
            locationManager.requestLocation()
        }
        else
        {
            locationManager.requestWhenInUseAuthorization()
        }
        
        locationManager.desiredAccuracy = .greatestFiniteMagnitude
        
        
        
    }
    
   
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        mapView.camera = GMSCameraPosition(target: CLLocationCoordinate2D(latitude:  locationManager.location?.coordinate.latitude ?? 0.0, longitude:  locationManager.location?.coordinate.longitude ?? 0.0), zoom: 10, bearing: 0, viewingAngle: 0)
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: locationManager.location?.coordinate.latitude ?? 0.0, longitude: locationManager.location?.coordinate.longitude ?? 0.0)
        marker.title = "Title"
        marker.snippet = "Here"
        marker.map = mapView
        
        
        print("Did Update Locations: Got here")
    }
    
    
    
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
        
        
        print("location Manager Did Change Authorization: Got here")
        print("Longittude = ", locationManager.location?.coordinate.longitude)
        print("Latitude = ", locationManager.location?.coordinate.latitude)
        
        
    }
   
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print(error)
    }

  

    
    

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    /*
     Check Authorisation:
     this code checks which authorisation
     the application has to get the user's location
     in the application
     */
  func checkAuthorisation()
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
        print("Button was pressed!!!")
        
        
        
    //    let locationObject = locationManager.location!
        let latitude = (locationManager.location?.coordinate.latitude ?? 0.0)
        let longitude = (locationManager.location?.coordinate.longitude ?? 0.0)
        
        
        print("Longittude = ", latitude)
        print("Latitude = ", longitude)
        

        
        let center = CLLocationCoordinate2D(
            latitude: locationManager.location?.coordinate.latitude ?? 0.0 ,
            longitude: locationManager.location?.coordinate.longitude ?? 0.0
        )
        
        
        let marker = GMSMarker()
        marker.position = center
        marker.title = "Current Location"
        marker.map = mapView
        let camera: GMSCameraPosition = GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude, zoom: 15)
        self.mapView.animate(to: camera)

        
    }
    
    

    
    
}
