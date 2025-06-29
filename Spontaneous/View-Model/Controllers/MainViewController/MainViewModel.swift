/*
 Project:           Spontaneous
 File:              MainViewModel.swift
 Created:           24/08/2023
 Author:            John Michael Crawley
 
 Description:
 This file handles returning any data
 from the models structs for the main
 menu and send it to the view controller
*/
//MARK: - Import list
import Foundation
import GoogleMaps


// Define a protocol for custom dialog box
protocol MainViewModelDelegate: AnyObject {
    func showCustomDialogBox(title: String, description: String, buttonTitle: String)
}



// MARK: - Main View Model
class MainViewModel
{
    
    // Weak reference to avoid retain cycles
       weak var delegate: MainViewModelDelegate?
    
    
    
    //MARK: - Return Selected Place
    func returnSelectedPlace() -> Place
    {
        let place = PlacesManager.shared.returnSinglePlace()
        return place
    }
    //MARK: - Return Places
    func returnPlacesCollection() -> [Place]
    {
        return PlacesManager.shared.returnPlacesCollection()
    }
    //MARK: - Append Place
    func appendPlaceToCollection(place: Place)
    {
        PlacesManager.shared.appendPlaceToCollection(place: place)
    }
    //MARK: - Return Place Count
    func returnPlaceCount() -> Int
    {
        return PlacesManager.shared.returnPlacesCollectionCount()
    }
    //MARK: - Get User Location
    func getUserLocation() -> String
    {
        let LAT = UserCoordinatesManager.shared.getUserCoordinates()?.latitude ?? 0.0
        let LONG = UserCoordinatesManager.shared.getUserCoordinates()?.longitude ?? 0.0
        let LOCATION = "\(LAT), \(LONG)"
        return LOCATION
    }
    //MARK: - Get Search Radius
    func returnSearchRadius() -> Float
    {
        return UserDefaults.standard.float(forKey: "radiusSliderValue")
    }
    // MARK: - Display Randomly Selected Place From Collection
    /*
     Select the random place from Places Manager to be displayed
     then set the camera and the info window (marker) to the
     place's lat' and long'.
     */
    func displayRandomlySelectedPlaceFromCollection(mapView: GMSMapView, marker: GMSMarker)
    {
        #if DEBUG
   //     print("Preparing to display a randomly selected place ....")
        print("* displayRandomlySelectedPlaceFromCollection: Preparing to display *")
        #endif
        // Set the place data and return it as a variable
        PlacesManager.shared.setSinglePlace()
        let place = returnSelectedPlace()
        // Check place lat + long
        if place.latitude != 0.0 && place.longitude != 0.0
        {
            // Set the map camera position
            let camera = GMSCameraPosition.camera(withLatitude: place.latitude, longitude: place.longitude, zoom: 15)
            mapView.camera = camera
            //  mapView.delegate = self
            marker.isTappable = false
            marker.position = CLLocationCoordinate2D(latitude: place.latitude, longitude: place.longitude)
            marker.tracksInfoWindowChanges = true
            marker.icon = GMSMarker.markerImage(with: .cyan)
            marker.userData = place // Attach the place object to the marker
            // Keep the info window open by setting appearAnimation to .none
            marker.appearAnimation = .pop
            // mapView.isUserInteractionEnabled = false
            // Enable the info window to stay open when tapping away
            mapView.settings.allowScrollGesturesDuringRotateOrZoom = false
            marker.map = mapView
            mapView.selectedMarker = marker
            // Update other UI elements as needed
        }
        else
        {
            #if DEBUG
            print("Place item is empty!!!")
            #endif
          //  self.delegate?.showCustomDialogBox(title: "No locations found!", description: "There was no locations found in the search, please adjust the filters / locations and try again or there's no places currently open.", buttonTitle: "Dismiss")
            // showCustomDialogBox(title: "No locations found!", description: "There was no locations found in the search, please adjust the filters / locations and try again or there's no places currently open.", buttonTitle: "OK")
        
        }
 
    }
    //MARK: - Check Application Search Cache
    /*
     Check if these cache variables have been changed / updated and if so return a bool value.
     For example if location U.I switches was set to 5 by the user & user presses button again
     after changing the location U.I switches to 4 then it will execute a new search since
     the cache has been changed.
     */
    func checkApplicationSearchCache() -> Bool
    {
        //
        let currentLocationSwitchCount = 0
        let currentPlacesCollectionCount = returnPlacesCollection().count
     //   let currentlUserLocation = ""
        
        // Get
        //PlacesManager.shared.findUILocationSwitchesTurnedOn().count
        
        // Check
        if currentPlacesCollectionCount != 0 || currentLocationSwitchCount != 0
        {
            return true
        }
        
       
        return false
    }
    //MARK: - Search Places For Keywords
    /*
     Using the user defined search filters (locations switches turned on, radius, pricing etc)
     loop over each keyword turned on in location switches then find each location, start a
     dispatch group to keep track and notify when the task is complete and make a request
     to Google API and get the JSON data and store it in temp' variables and add it to the place
     collection array. If nothing is found, output a message to the user
     */
    func searchGoogleAPIForPlacesWithKeywords(keywords: [String], completion: @escaping () -> Void)
    {
        #if DEBUG
        print("* searchGoogleAPIForPlacesWithKeywords: Searching Google API *")
        #endif
        // Create a dispatch group to keep track and notify when task is complete
        let dispatchGroup = DispatchGroup()
        // Loop over each keyword found in keywords
        for keyword in keywords
        {
            dispatchGroup.enter()
            let url = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=\(getUserLocation())&radius=\(returnSearchRadius())&keyword=\(keyword)&fields=name,opening_hours&key=\(GoogleAPIManager.shared.returnAPIKey())"
            guard let requestURL = URL(string: url) else
            {
                dispatchGroup.leave()
                continue
            }
            let request = URLRequest(url: requestURL)
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                // Create an optional unwrapping of the JSON data
                if let data = data
                {
                    do
                    {
                        let root = try JSONDecoder().decode(Root.self, from: data)
                        for result in root.results
                        {
                            // Declare and store values
                            let placeID = result.place_id ?? ""
                            let placeName = result.name ?? ""
                            let placeAddress = result.formatted_address ?? ""
                            let openingHours = result.opening_hours?.open_now ?? false
                            let placeTypes = result.types ?? [""]
                            let placeRating = result.rating ?? 0.0
                            let placeLat = result.geometry?.location.lat ?? 0.0
                            let placeLong = result.geometry?.location.lng ?? 0.0
                            let placePricingRange  = result.price_level ?? 0
                            let placePhotos = result.photos ?? [Photo(height: 0, width: 0, htmlAttributions: [], photoReference: "")]
                            // If placeID is found in the array, skip this iteration
                            // or if place type is not found by keyword specific, skip this iteration
                            // or if a location / place is closed
                            if self.returnPlacesCollection().filter({ $0.placeID == placeID }).count > 0 || !placeTypes.contains(keyword) || openingHours == false
                            {
                                continue
                            }
                            // Finally, add place to the places array
                            else
                            {
                                let place = Place(placeID: placeID, name: placeName, address: placeAddress, isOpenNow: openingHours, types: placeTypes, rating: placeRating, pricingRange: placePricingRange, photo: placePhotos, latitude: placeLat,longitude: placeLong)
                                self.appendPlaceToCollection(place: place)
                                // Print if there's an error
                                if let error = error
                                {
                                    #if DEBUG
                                    print("Error in data task: \(error.localizedDescription)")
                                    #endif
                                    return
                                }
                            }
                        }
                        DispatchQueue.main.async
                        {
                            if self.returnPlaceCount() == 0
                            {
                                #if DEBUG
                               // print("\(keyword) came up empty")
                                #endif
                                // THIS WILL CAUSE A WARNING DUE TO LOOP (MAYBE)
                              //  self.delegate?.showCustomDialogBox(title: "No locations found!", description: "There was no locations found in the search, please adjust the filters / locations and try again or there's no places currently open.", buttonTitle: "OK")
                            }
                            else
                            {
                                #if DEBUG
                                //   print("Display random item?")
                                #endif
                            }
                        }
                    }
                    catch
                    {
                        #if DEBUG
                        print(error)
                        #endif
                        DispatchQueue.main.async
                        {
                            // THIS WILL CAUSE A WARNING DUE TO LOOP (MAYBE)
                            self.delegate?.showCustomDialogBox(title: "Error!", description: "Error found: \(error)", buttonTitle: "Dismiss")
                        }
                    }
                    // Leave the dispatch group when the task is completed
                       dispatchGroup.leave()
                }
            }
            task.resume()
        }
        // Notify the completion handler when all tasks are completed
        dispatchGroup.notify(queue: .main) { completion() }
    }
    
    
  

    // Helper method to present a new CustomDialogBox
    private func presentNewDialog(title: String, description: String, buttonTitle: String) 
    {
        let dialog = CustomDialogBox()
        dialog.showDialog(title: title, description: description, buttonTitle: buttonTitle)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
