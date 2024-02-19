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
// MARK: - Main View Model
class MainViewModel
{
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
    func displayRandomlySelectedPlaceFromCollection(mapView: GMSMapView, marker: GMSMarker)
    {
        #if DEBUG
   //     print("Preparing to display a randomly selected place ....")
        print("* displayRandomlySelectedPlaceFromCollection: Preparing to display *")
        #endif
        // Set the place data and return it as a variable
        PlacesManager.shared.setSinglePlace()
        let place = returnSelectedPlace()
        
        print(" Main View Model: Place = \(place)")
        
        
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
        }
 
    }
    //MARK: - Search Places For Keywords
    func searchGoogleAPIForPlacesWithKeywords(keywords: [String])
    {
        #if DEBUG
        print("* searchGoogleAPIForPlacesWithKeywords: Searching Google API *")
        #endif
        
        
        
        
       // print("here outside keywords")
        for keyword in keywords
        {
            // Replace var below with the code after in prod.
            
          //  let LOCATION = "53.293838223653765, -6.134797540594663" //DUBLIN
            //  let LOCATION = "34.04774145141665, -118.25183327671387" // L.A - CALIFORNIA
            // let LOCATION = "34.6938968703894, 135.4958862124797" // OSAKA
            // let LOCATION = mainViewModel.getUserLocation()
            
            //   let LOCATION = "35.714721941022844, 139.77320633686915"
           // let LOCATION = "\(UserCoordinatesManager.shared.getUserCoordinates()?.latitude ?? 0.0), \(UserCoordinatesManager.shared.getUserCoordinates()?.longitude ?? 0.0)"
            
          //  print("here in keywords")
            
           // let url = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=\(getUserLocation())&radius=\(returnSearchRadius())&keyword=\(keyword)&fields=name,opening_hours&key=\(GoogleAPIManager.shared.returnAPIKey())"
            

            
         //   print("print the user loc' ", getUserLocation())
            
            let url = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=\(getUserLocation())&radius=\(returnSearchRadius())&keyword=\(keyword)&fields=name,opening_hours&key=\(GoogleAPIManager.shared.returnAPIKey())"
            
            
            let requestURL = URL(string: url)!
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
                            
                            #if DEBUG
                          //  print("Finding place = ", placeName)
                            #endif
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
                                // x here
                              
                                let place = Place(placeID: placeID, name: placeName, address: placeAddress, isOpenNow: openingHours, types: placeTypes, rating: placeRating, pricingRange: placePricingRange, photo: placePhotos, latitude: placeLat,longitude: placeLong)
                                self.appendPlaceToCollection(place: place)
                               
                            //    print("* Place in search: ", place, " *")
                                
                                if let error = error 
                                {
                                    print("Error in data task: \(error.localizedDescription)")
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
                            }
                            else
                            {
                                // self.displayRandomlySelectedPlaceFromCollection()
                              //  PlacesManager().di
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
                              //displayDialogAlert(title: "No Locations Found:", message: "There was no locations found in the search, please adjust the filters/locations and try again.")
                        }
                    }
                }
            }
            task.resume()
        }
    }
}
