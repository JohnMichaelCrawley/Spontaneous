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
    /*
     This button loads the data from either Google API request using
     fetchPlaceFromGoogleAPI() function or if there's cache for the
     data already loaded in / filters haven't been chanced since
     the last time it was used then it will load the data from
     the cache memory (places collection). If nothing is found
     it will then display a custom dialog box to tell the user
     to adjsut their filters or that there are no locations currently
     open for business.
     */
    @objc func beSpontaneousButtonPressed()
    {
        #if DEBUG
        print("*-------------------------*")
        #endif
        #if DEBUG
        print("* Be Spontaneous button pressed *")
        //   print("* Be Spontaneous Button Has Been Pressed *")
        #endif
        // Fetch places from Google API
        fetchPlaceFromGoogleAPI()
        // Check if places collection (array) isn't equal to 0
        if mainViewModel.returnPlacesCollection().count != 0
        {
            PlacesManager().setSinglePlace()
            
            mainViewModel.displayRandomlySelectedPlaceFromCollection(mapView: mapView, marker: marker)
        }
        // Else the places collection (array) is equal to 0
        else
        {
            
        }
        #if DEBUG
        print("*-------------------------*")
        #endif
    }
    //MARK: - Fetch Places From Google API
    /*
     Using the location switches that are turned on
     (such as cafe, cinema, park etc) it will loop over each one
     of them using the function searchGoogleAPIForPlacesWithKeywords()
     in the main view-model class and return the data and then load up
     the custom view for the info window and the button for getting directions.
     */
    func fetchPlaceFromGoogleAPI()
    {
        let locationSwitchesTurnedOn = PlacesManager.shared.findUILocationSwitchesTurnedOn()
        mainViewModel.searchGoogleAPIForPlacesWithKeywords(keywords: locationSwitchesTurnedOn) 
        {
            #if DEBUG
            print("Search operation completed successfully!")
            #endif
            DispatchQueue.main.async 
            {
                #if DEBUG
                print("* fetchPlaceFromGoogleAPI(): has \(self.mainViewModel.returnPlaceCount()) places. *")
                #endif
                // If there's an item in the collection
                if self.mainViewModel.returnPlacesCollection().count != 0
                {
                    self.mainViewModel.displayRandomlySelectedPlaceFromCollection(mapView: self.mapView, marker: self.marker)
                    self.configureCustomInfoWindowView()
                    self.configureGetDirectionsButton()
                }
                else
                {
                    self.showCustomDialogBox(title: "No locations found!", description: "No locations found, please adjust the filters / locations and try again or there's no places currently open.", buttonTitle: "Dismiss")
                }
            }
        }
    }
}
