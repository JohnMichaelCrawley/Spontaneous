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
    // MARK: - Variables
    private var isToggleActive = false
    /* VARIABLES */
    // Previous Switch count - store the previous switches that are on/off in this counter
    private var previousSwitchCount = 0
    // Google Map / Map View / Marker Variables
    @IBOutlet weak var mapView: GMSMapView!
    private  var marker = GMSMarker()
    // Theme Manager
    private let themeManager = ThemeManager()
    // Location Manager
    private var locationManager = CLLocationManager()
    // User Defaults
    private let USERDEFAULTS = UserDefaults.standard
    // Place variable (store single datum of a place found) and places array to store all data found in Google API search
    private var place: Place = Place(placeID: "", name: "", address: "", isOpenNow: false, types: [""], rating: 0.0, latitude: 0.0, longitude: 0.0)
    private var places: [Place] = []
    // Store location data
    private var businessLocation = CLLocationCoordinate2D(latitude: 0.0,longitude: 0.0)
    private var userLocation = CLLocationCoordinate2D(latitude: 0.0,longitude: 0.0)
    private var businessLatitude: Double =  0.0
    private var businessLongitude: Double = 0.0
    private var userLatitude: Double = 0.0
    private var userLongitude: Double = 0.0
    // MARK: - View Did Load
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Check Notification Center for changes in theme
        NotificationCenter.default.addObserver(self, selector: #selector(updateMapStyle(_:)), name: NSNotification.Name(rawValue: "mapThemeDidChange"), object: nil)
        // Theme Manager - Theme Selection
        checkForApplicationThemeOnBoot()
        // Set up Location Manager
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
            {self.locationManager.requestLocation()}
            else
            {self.locationManager.requestWhenInUseAuthorization()}
        }
        // Set up MapView
        mapView.isMyLocationEnabled = true  // SHOWS BLUE DOT FOR USER'S LOCATION
        mapView.delegate = self
    }
    /*
     viewWillAppear:
     This override function brings back the tab view
     controller to the main view controllers
     */
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        // Enable TabBar
        self.tabBarController?.tabBar.isHidden = false
        // Force the map view to redraw itself
        mapView.setNeedsDisplay()
        // Force the map view to re-layout its subviews
        mapView.setNeedsLayout()
    }
    /*
     Update Map Style:
     This function sets the map in either dark mode
     or keep it in the default style of light mode.
     */
    @objc func updateMapStyle(_ notification: NSNotification)
    {
        let themeValue = USERDEFAULTS.string(forKey: "applicationTheme") ?? ""
        #if DEBUG
        print("Notification Center: Function: Theme Value = \(themeValue) ")
        #endif
        themeManager.setEntireApplicatonTheme(theme: themeValue, mapView: mapView)
    }
    /*
     Function - Check For Application Theme On Boot:
     This function checks what theme the application should
     be in when the app is launched. I tried adding this to the
     Theme Manager but it wouldn't register the function
     on boot load
     */
    func checkForApplicationThemeOnBoot()
    {
        let theme = USERDEFAULTS.string(forKey: "applicationTheme") ?? ""
        themeManager.setEntireApplicatonTheme(theme: theme, mapView: mapView)
        let window = UIApplication.shared.connectedScenes.compactMap { ($0 as? UIWindowScene)?.keyWindow }.first
        if theme == "dark"
        { window?.overrideUserInterfaceStyle = .dark }
        else if theme == "light"
        { window?.overrideUserInterfaceStyle = .light }
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
      //  setBusinessLocation(businessLocation: businessLocation, userLocation: userLocation)
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
     Function - Be Spontaneous Pressed:
     This is an IBAction button, when pressed
     it will check for the places array count
     to see if the array is populated and if not
     (which is what will happen first time loading
     the app'). The app' will use Google's search request
     from Google Places API. If no places are found then
     it will execute the fetchPlaces() function, however,
     if there are places found in the array it will
     execute another function to output from the array
     itself.
     */
    @IBAction func beSpontaneousPressed(_ sender: Any)
    {
        // BUTTON VARIABLES//
        // TESTING VARIABLE FOR BIG O
        let startTime = CFAbsoluteTimeGetCurrent() // START TIME
        let dots = "****************************************"
        previousSwitchCount = getLoctionSwitchOnCount()
        if places.count == 0
        {
            #if DEBUG
            print("* Google API: request is being used *")
            #endif
            fetchPlaces()
        }
        else
        {
            #if DEBUG
            print("* Places Array: is being used *")
            #endif
            outputFromPlacesArray()
        }
        
        // TESTING VARIABLE FOR BIG O
        let timeElapsed = CFAbsoluteTimeGetCurrent() - startTime // END TIME
        
        #if DEBUG
        print("\n\n\(dots)\nTime it took to execute this button is:\n \(timeElapsed)\n\(dots)\n\n")
        #endif
        // Time it took to execute this button is 0.0015050172805786133
        
        print("* * * Place Array Count : \(places.count)")
    }
    /*
     Function - Fetch Places:
     This function finds the random thing to do.
     It creates the filters for the search the top of
     the function (kEYWORD, LOCATION, RADIUS etc)
     then loops over the amount of switches currently
     activated and uses that for the for loop search
     quantity. Then check the Google Place JSON
     and store it in a temp' variable, use the variable
     to check against the array if there's duplicates,
     check against the keyword to make sure it doesn't
     give random keywords and if none of these are met
     the append the place found to the array.
     */
    func fetchPlaces()
    {
        for _ in 0...getLoctionSwitchOnCount()
        {
            // Search radius
            let RADIUS = USERDEFAULTS.float(forKey: "searchRadiusFilter")
            // Keyword for the search
            let KEYWORD = getRandomKeyword()
            // User location
            let userLatitude = locationManager.location?.coordinate.latitude ?? 0.0
            let userLongitude = locationManager.location?.coordinate.longitude ?? 0.0
            let LOCATION = "\(userLatitude),\(userLongitude)"
            let url = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=\(LOCATION)&radius=\(RADIUS)&keyword=\(KEYWORD)&fields=name,opening_hours&key=\(API().returnAPIKey())"
            let requestURL = URL(string: url)!
            let request = URLRequest(url: requestURL)
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let data = data
                {
                    do
                    {
                        let root = try JSONDecoder().decode(Root.self, from: data)
                        for result in root.results
                        {
                            let placeID = result.place_id ?? ""
                            let placeName = result.name ?? ""
                            let placeAddress = result.formatted_address ?? ""
                            let openingHours = result.opening_hours?.open_now ?? false
                            let placeTypes = result.types ?? [""]
                            let placeRating = result.rating ?? 0.0
                            let placeLat = result.geometry?.location.lat ?? 0.0
                            let placeLong = result.geometry?.location.lng ?? 0.0
                            // If placeID is found in the array, skip this iteration
                            // or if place type is not found by keyword specific, skip this iteration
                            // or if a location / place is closed
                            if self.places.filter({ $0.placeID == placeID }).count > 0 || !placeTypes.contains(KEYWORD) || openingHours == false
                            {
                                continue
                            }
                            // Finally, add place to the places array
                            else
                            {
                                let place = Place(placeID: placeID, name: placeName, address: placeAddress, isOpenNow: openingHours, types: placeTypes, rating: placeRating, latitude: placeLat,longitude: placeLong)
                                self.places.append(place)
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
                        print(error)
                        #endif
                        DispatchQueue.main.async
                        {
                          //  self.displayDialogAlert(title: "No Locations Found:", message: "There was no locations found in the search, please adjust the filters/locations and try again.")
                        }
                    }
                }
            }
            task.resume()
        }
    }
    /*
     Output From Places Array:
     If there's values in the array
     the use the array over usage of
     requesting Google API to reduce
     the billing amounts.
     --------------------------
     Problem Needs working on:
     I need this function to check whether
     or not specific switches are on. If
     switch is off include a search for that
     specific switch and then remove it from places array.
     If the switch is on but that type is not in the places
     array then do a search for that type and include it.
     */
    func outputFromPlacesArray()
    {
        if getLoctionSwitchOnCount() > previousSwitchCount || getLoctionSwitchOnCount() < previousSwitchCount
        {
            print("Fetch places has been called!")
            fetchPlaces()
        }
        else
        {
            displayRandomPlace()
        }
    }
    // Return random place to the place variable at the top of the file
    func returnRandomPlace() -> Place
    {
        let place = places.getRandomPlace()!
        return place
    }
    /*
     Display Random Place:
     If the array of places is not empty then
     get a random place, place it's position on
     the map and send the name, lat and long over
     to User Defaults to be used on
     GetDirectionsViewController
     */
    func displayRandomPlace()
    {
        if places.count != 0
        {
            // Get a random element from the places array
             place = returnRandomPlace()
            // Set up the marker information
            marker.position = CLLocationCoordinate2D(latitude: place.latitude, longitude: place.longitude)
            // Change marker colour
            marker.icon = GMSMarker.markerImage(with: .cyan)
            marker.map = mapView
            let camera: GMSCameraPosition = GMSCameraPosition.camera(withLatitude: place.latitude, longitude: place.longitude, zoom: 15)
          //  let center = CLLocationCoordinate2D(latitude: place.latitude,longitude: place.longitude)
            mapView.selectedMarker = marker
            self.mapView.animate(to: camera)
            // Send data over USER DEFAULTS
            USERDEFAULTS.set(place.name, forKey: "placeName")
            USERDEFAULTS.set(place.latitude, forKey: "placeLatitude")
            USERDEFAULTS.set(place.longitude, forKey: "placeLongitude")
        }
    }
    /*
     This function iterates through the USERDEFAULS
     for keys containing switches and if the switch
     is turned on. If these conditions are true,
     it stores it in the kewords array and remove
     the prefix of, "Switch" then after the iteration
     it will randomly pick a random key to be used
     as the type of business/place to use for the
     search
     */
    func getRandomKeyword() -> String
    {
        var keyword = ""
        var keywords = [String]()
        for (key, value) in USERDEFAULTS.dictionaryRepresentation()
        {
            if key.contains("Switch") && value as! Int == 1
            {
                #if DEBUG
               // print("KEYWORDS = \(key)")
                #endif
                let element = key.replacingOccurrences(of: "Switch", with: "")
                #if DEBUG
               //  print("element = \(element)")
                #endif
                keywords.append(element)
            }
        }
        if keywords.count > 1
        {
            keyword = keywords.randomElement()!
        }
        
        return keyword
    }
    /*
     Switch Count:
     Return the amount of switches turned on.
     This is used to generate a number for a loop
     */
    func getLoctionSwitchOnCount() -> Int
    {
        var onCounter = 0
        var i = 0
        var switches = [String]()
        for (key, value) in USERDEFAULTS.dictionaryRepresentation()
        {
            if key.contains("Switch") && value as! Int == 1
            {
                let switchValue = "\(value)"
                switches.append("\(value)")
                if switches[i] != switchValue
                {
                    i += 1
                    onCounter += i
                }
            }
        }
        #if DEBUG
        print("Switches array counter : \(switches.count)")
        #endif
        return switches.count
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
/*
 EXTENSIONS:
 These extensions implement the Fisher-Yates
 algorithm into search for random place
 then returning a random place from the array
 */
extension [Place]
{
    /// Return a copy of `self` with its elements shuffled
    func shuffle() -> [Iterator.Element]
    {
        var list = Array(self)
        list.shufflePlaces()
        return list
    }
}
extension [Place] where Index == Int
{
    /// Shuffle the elements of `self` in-place.
    mutating func shufflePlaces()
    {
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
extension [Place]
{
    mutating func getRandomPlace() -> Element?
    {
        shufflePlaces()
        if isEmpty {return nil}
        let indexOfRandomItemInArray = Int(arc4random_uniform(UInt32(self.count)))
        return self[indexOfRandomItemInArray]
    }
}
/*
 GMS Map View Delegate:
 What this part of the code is create a view
 of the UI View InfoWindow and populate it to
 the map. Google creates basically an image
 of the UI View and for now I allowed the marker
 to act as an entire button until I get arround
 to properly implementing the button
 -
 Resource to try use:
 http://kevinxh.github.io/swift/custom-and-interactive-googlemaps-ios-sdk-infowindow.html
 */

extension ViewController: GMSMapViewDelegate
{
    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView?
    {
        let infoWindow = Bundle.main.loadNibNamed("InfoWindow", owner: self, options: nil)?.first as! InfoWindow
        // SET UP VARIABLES
        let name = place.name
        let rating = place.rating
      //  let lat = place.latitude
      //  let lng = place.longitude
        let types = place.types
        let isOpen = place.isOpenNow
        var openHours: String
        if isOpen == true
        {openHours = "Open Now"} else {openHours = "Closed"}
        // Types output
        let typesOutput = types.joined(separator: ", ")
        // Set data to info window
        infoWindow.placeNameLabel.text = "\(name)"
        infoWindow.placeRatingLabel.text = "Rating: \(rating)"
        infoWindow.placeTypesLabel.text = "Type: \n\(typesOutput)"
        infoWindow.placeOpenHoursLabel.text = "\(openHours)"
        // Corner Radius
        infoWindow.layer.cornerRadius = 10
        // Border
        infoWindow.layer.borderWidth = 0.5
        infoWindow.layer.borderColor = UIColor.lightGray.cgColor
        // Return Info Window
        return infoWindow
    }
    // On InfoWindow tap then execute get Directions func
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker)
    {
        getDirections()
    }
    // Open Navigation Tab View
    func getDirections()
    {
        #if DEBUG
      //  print("print print tap tap")
        #endif
        let getDirectionsVC = self.storyboard!.instantiateViewController(withIdentifier: "getDirectionsVC")
        self.navigationController?.pushViewController(getDirectionsVC, animated: true)
    }
}
