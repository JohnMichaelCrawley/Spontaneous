/*
 Project:           Spontaneous
 File:              MainViewControllerUserInterfaceActions.swift
 Created:           06/09/2023
 Author:            John Michael Crawley
 
 Description:
 This file handles user interface actions done on the
 main view controller
 */
//MARK: - Import list
import UIKit
import GoogleMaps
import GooglePlaces
//MARK: - Main View Controller Extension - Configure
extension MainViewController
{
    //MARK: - Be Spontaneous Button Pressed
    @objc func beSpontaneousButtonPressed()
    {
       fetchPlaceFromGoogleAPI()
    }
    //MARK: - Fetch Places From Google API 
    func fetchPlaceFromGoogleAPI()
    {
        let KEYWORD = "cafe"
        // Replace var below with the code after in prod
      //  let LOCATION = "53.293838223653765, -6.134797540594663" //DUBLIN
        let LOCATION = "34.04774145141665, -118.25183327671387" // L.A - CALI
       // let LOCATION = mainViewModel.getUserLocation()
        let url = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=\(LOCATION)&radius=\(mainViewModel.returnSearchRadius())&keyword=\(KEYWORD)&fields=name,opening_hours&key=\(GoogleAPIManager.shared.returnAPIKey())"
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
                        // If placeID is found in the array, skip this iteration
                        // or if place type is not found by keyword specific, skip this iteration
                        // or if a location / place is closed
                        if self.mainViewModel.returnPlacesCollection().filter({ $0.placeID == placeID }).count > 0 || !placeTypes.contains(KEYWORD) || openingHours == false
                        {
                            continue
                        }
                        // Finally, add place to the places array
                        else
                        {
                            let place = Place(placeID: placeID, name: placeName, address: placeAddress, isOpenNow: openingHours, types: placeTypes, rating: placeRating, pricingRange: placePricingRange, latitude: placeLat,longitude: placeLong)
                            
                            self.mainViewModel.appendPlaceToCollection(place: place)
                            
                        }
                    }
                    DispatchQueue.main.async
                    {
                        if self.mainViewModel.returnPlaceCount() == 0
                        {
                            print("Empty array")
                        }
                        else
                        {
                            self.displayRandomlySelectedPlaceFromCollection()
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
                        //  self.displayDialogAlert(title: "No Locations Found:", message: "There was no locations found in the search, please adjust the filters/locations and try again.")
                    }
                }
            }
        }
        task.resume()
    }
    // MARK: - Display Randomly Selected Place From Collection
    func displayRandomlySelectedPlaceFromCollection() 
    {
        #if DEBUG
        print("Preparing to display a randomly selected place ....")
        #endif
        // Get a random place from your view model
        let place = mainViewModel.getRandomPlace()
        if let place = place
        {
            #if DEBUG
            print("\n")
            print("""
                Business Name: \(place.name)
                Business Address: \(place.address)
                Buisness Coordinates: \(place.latitude), \(place.longitude)
                """)
            print("\n")
            #endif
            // Set the map camera position
            let camera = GMSCameraPosition.camera(withLatitude: place.latitude, longitude: place.longitude, zoom: 15)
            mapView.camera = camera
            mapView.delegate = self
            marker.isTappable = true
            marker.position = CLLocationCoordinate2D(latitude: place.latitude, longitude: place.longitude)
            marker.tracksInfoWindowChanges = true
            marker.icon = GMSMarker.markerImage(with: .cyan)
            marker.userData = GoogleInfoWindowView() // Attach the custom info view to the marker
            // Keep the info window open by setting appearAnimation to .none
            marker.appearAnimation = .none       
            marker.map = mapView
            mapView.selectedMarker = marker
        }
        else
        {
            #if DEBUG
            print("Failed to get a random place from the view model.")
            #endif
        }

    }
}
