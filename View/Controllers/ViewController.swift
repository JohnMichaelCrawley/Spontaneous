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
   

  //  var CustomInfoWindow = CustomInfoWindow()
 //   private var infoWindow = CustomInfoWindow()
    
    
     
    
    
    
    
    
    var locationManager = CLLocationManager()           // LocationManager: Get information on coordinates from the user etc //
    let USERDEFAULTS = UserDefaults.standard            // USERDEFAULTS: used to access stored data i.e settings //
    // Get the business data structs etc from Business file //
    var places: [Place] = []                         // Array to store all the businesses and places in an array to shuffle//
    // GOOGLE MAPS
    var marker = GMSMarker()                            // Google Maps Marker (Pop up)
    /*
     User and Business location:
     Store the business lat' and long' to be used to center the camera to
     */
    var businessLocation = CLLocationCoordinate2D(latitude: 0.0,longitude: 0.0)
    var userLocation = CLLocationCoordinate2D(latitude: 0.0,longitude: 0.0)
    var businessLatitude: Double =  0.0
    var businessLongitude: Double = 0.0
    var userLatitude: Double = 0.0
    var userLongitude: Double = 0.0
   
    
    

    /*
     View Did Load:
     This func is called when loading a view controller hierarchy into memory.
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
        // Update the map style based on user selection //
        updateMapStyle()
        /*
         MAP VIEW SETTINGS:
         Include or adjust the mapView properties
         */
        mapView.isMyLocationEnabled = true  // SHOWS BLUE DOT FOR USER'S LOCATION

        mapView.delegate = self
 
      //

        
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
        // BUTTON VARIABLES//
        // TEST COORDINATES - USED FOR TESTING PURPOSES
        let userLatitude = 53.347568
        let userLongitude = -6.259353
        //let userLatitude = locationManager.location?.coordinate.latitude ?? 0.0
        //let userLongitude = locationManager.location?.coordinate.longitude ?? 0.0
        // TESTING VARIABLE FOR BIG O
        let startTime = CFAbsoluteTimeGetCurrent() // START TIME
        /*
         START THE ALGORITHM:
         Start the loop to generate multiple types of places/businesses
         and allocate them into the business array.
         */
        fetchPlaces()

        
        /*
         END THE ALGORITHM:
         
         */
        // TESTING VARIABLE FOR BIG O
        let timeElapsed = CFAbsoluteTimeGetCurrent() - startTime // END TIME
        let dots = "****************************************"
        #if DEBUG
        print("\n\n\(dots)\nTime it took to execute this button is:\n \(timeElapsed)\n\(dots)\n\n")
        #endif
        // Time it took to execute this button is 0.0015050172805786133
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    func fetchPlaces()
    {
        // SEARCH FILTERS
        let RADIUS = USERDEFAULTS.float(forKey: "searchRadiusFilter")
    
        let KEYWORD = "cafe"
        let location = "53.347568,-6.259353"

        
        let url = URL(string: "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=\(location)&radius=\(RADIUS)&type=\(KEYWORD)&key=\(API().returnAPIKey())")
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            guard let data = data else { return }
           // print("--> data: \(String(data: data, encoding: .utf8))")
          //  print(String(data: data, encoding: .utf8) ?? "*")
        
            do
            {
               // let result = try JSONDecoder().decode(Root.self, from: data).results
                let result = try JSONDecoder().decode(Root.self, from: data).results
                let resultCount = result.count
                let i = Int.random(in: 0..<resultCount)
                
                for _ in result
                {
                    let placeID = result[i].place_id ?? ""
                    let placeName = result[i].name ?? ""
                    let placeAddress = result[i].formatted_address ?? ""
                    let phoneNumber = result[i].formatted_phone_number ?? ""
                    let openingHours = result[i].openingHours?.openNow ?? false
                    let website = result[i].website ?? ""
                    let placeTypes = result[i].types ?? [""]
                    let placeRating = result[i].rating ?? 0.0
                    let placePhotoReference = result[i].photos![0].photoReference
                    let placeLat = result[i].geometry?.location.lat ?? 0.0
                    let placeLong = result[i].geometry?.location.lng ?? 0.0
                    
                    let string = placeID
                    if self.places.filter({ $0.placeID == string }).count > 0
                    {
                        // PlaceID is already in array
                    }
                    else
                    {
                        // PlaceID is NOT in arrayphoneNumber', 'openingHours', 'website'
                        let place = Place(placeID: placeID,
                                          name: placeName,
                                          address: placeAddress,
                            
                                          openingHours: openingHours,
                                          types: placeTypes,
                                          rating: placeRating,
                                          photoReference: placePhotoReference,
                                  
                                          latitude: placeLat,
                                          longitude: placeLong
                        )
                        self.places.append(place)
                      //  print(place)
                    }
                }
                
                DispatchQueue.main.async
                {
                    self.displayRandomPlace()
                }
            
            }
            catch
            {
                #if DEBUG
                print("""
                      \n
                     ************************************************\n\(error)
                     \n************************************************\n
                     """)
                #endif
            }
        }.resume()


    }

    
    
    
    
    
    func displayRandomPlace()
    {
        if places.count != 0
        {
            let randomIndex = Int.random(in: 0..<places.count)
            let place = places[randomIndex]
            
         
            
            marker.position = CLLocationCoordinate2D(latitude: place.latitude, longitude: place.longitude)
            
      
            marker.title = "\(place.name)"
            
            marker.snippet = """
                             Rating : \(place.rating)
                             Address : \(place.address)
                             Types : '\(place.types)
                             """
         
            marker.map = mapView
    
    
       
             
            
            let camera: GMSCameraPosition = GMSCameraPosition.camera(withLatitude: place.latitude, longitude: place.longitude, zoom: 15)
            let center = CLLocationCoordinate2D(latitude: place.latitude,longitude: place.longitude)
            mapView.selectedMarker = marker
            self.mapView.animate(to: camera)
  
            // textbox.text = "Name: \(place.name)\nAddress: \(place.address)\nRating: \(place.rating)\nTypes:\(place.types)\nLat: \(place.latitude)\nLong: \(place.longitude)"
            
            let imageURL = "https://maps.googleapis.com/maps/api/place/photo?photoreference=\(place.photoReference)&sensor=false&maxheight=400&maxwidth=400&key=\(API().returnAPIKey())"
            
            
            let task = URLSession.shared.dataTask(with: URL(string: imageURL)!) { (data, response, error) in
                if let data = data
                {
                    let name = place.name
                    let rating = place.rating
                    let image = UIImage(data: data)!
                    
                    DispatchQueue.main.async
                    {
                        //   self.image.image = UIImage(data: data)
                      
                    }
                }
                
            }
            task.resume()
        }
        else
        {
            // textbox.text = "No data."
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
        let circle = GMSCircle()
        
      

        
        let loc = CLLocationCoordinate2D(latitude: 53.347568, longitude: -6.259353)
        
        isToggleActive = !isToggleActive
        // TRUE = TOGGLE ON
        if isToggleActive
        {
            circle.map = nil
            circle.radius = 0
            circle.radius = CLLocationDistance(RADIUS) // Meters
            circle.fillColor = UIColor.red
            circle.position = loc // Your CLLocationCoordinate2D  position
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







extension [String]
{
    /// Return a copy of `self` with its elements shuffled
    func shuffle() -> [Iterator.Element] {
        var list = Array(self)
        list.shufflePlaces()
        return list
    }
}


extension [String] where Index == Int
{
    /// Shuffle the elements of `self` in-place.
    mutating func shufflePlaces() {
        // empty and single-element collections don't shuffle
        if count < 2 { return }
        for i in 0..<count - 1
        {
            let j = Int(arc4random_uniform(UInt32(count - i))) + i
            guard i != j else { continue }
            self.swapAt(i, j)
        }
    }
}



extension Array
{
    mutating func removeRandom() -> Element? {
        if let index = indices.randomElement() {
            return remove(at: index)
        }
        return nil
    }
}




/*
 Resource to try use:
 http://kevinxh.github.io/swift/custom-and-interactive-googlemaps-ios-sdk-infowindow.html
 */

extension ViewController: GMSMapViewDelegate
{
    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView?
    {
        let infoWindow = Bundle.main.loadNibNamed("InfoWindow", owner: self, options: nil)?.first as! InfoWindow
        
        
        let randomIndex = Int.random(in: 0..<places.count)
        // Place info
        let place = places[randomIndex]
        var openHours: String
        let placeTypes = place.types
        
        if place.openingHours == true
        {openHours = "Open Now"} else {openHours = "Closed"}
    
        //   self.image.image = UIImage(data: data)
        infoWindow.PlaceNameLabel.text = "\(place.name)"
        infoWindow.placeRatingLabel.text = "Rating: \(place.rating)"
        infoWindow.placeTypesLabel.text = "Type: \(place.types)"
        infoWindow.placeOpenHoursLabel.text = "\(openHours)"
       
        // Corner Radius
        infoWindow.layer.cornerRadius = 10
        // Border
        infoWindow.layer.borderWidth = 0.5
        infoWindow.layer.borderColor = UIColor.lightGray.cgColor
        // Shadow
       // infoWindow.getDirectionsButton.addTarget(self, action: #selector(getDirections(_:)), for: .touchUpInside)
    

        
        
        // Return Info Window
        return infoWindow
    }
    
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        getDirections()
        
    }
    func getDirections()
    {
        #if DEBUG
        print("print print tap tap")
        #endif

        
        let getDirectionsVC = self.storyboard!.instantiateViewController(withIdentifier: "getDirectionsVC")

        // performSegue(withIdentifier: "mySegueID", sender: nil)

       // performSegue(withIdentifier: "getDirectionsVC", sender: nil)
        

        
        
        self.navigationController?.pushViewController(getDirectionsVC, animated: true)
        // your code
       // getDirectionsVC.modalPresentationStyle = .fullScreen

      // self.present(getDirectionsVC, animated: true, completion: nil)
      
        
    }
}
