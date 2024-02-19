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
        #if DEBUG
        print("*-------------------------*")
        #endif
        #if DEBUG
        print("* Be Spontaneous button pressed *")
        //   print("* Be Spontaneous Button Has Been Pressed *")
        #endif
        fetchPlaceFromGoogleAPI()
        if mainViewModel.returnPlacesCollection().count != 0
        {
            PlacesManager().setSinglePlace()
            
            mainViewModel.displayRandomlySelectedPlaceFromCollection(mapView: mapView, marker: marker)
        }
        else
        {
            // print("No items in the collection")
        }
        #if DEBUG
        print("*-------------------------*")
        #endif
    }
    //MARK: - Fetch Places From Google API 
    func fetchPlaceFromGoogleAPI()
    {
        #if DEBUG
        /*
        print("=======================================")
        print("Printing User Location\n")
        print(mainViewModel.getUserLocation())
        print(MainViewModel().getUserLocation())
        print("=======================================")
         
         */
        print("* fetchPlaceFromGoogleAPI(): Fetching Places *")
        #endif
        #if DEBUG
        /*
        print("=======================================")
        print("Printing Location Switches Turned On:\n")
        print("Switches", locationSwitchesTurnedOn)
        print("Count", locationSwitchesTurnedOn.count)
        print("=======================================")
         */
        #endif
        let locationSwitchesTurnedOn = PlacesManager.shared.findUILocationSwitchesTurnedOn() // Array for each switch turned on
        // Search and store places found using each keyword (UI Switch) turned on
        mainViewModel.searchGoogleAPIForPlacesWithKeywords(keywords: locationSwitchesTurnedOn)
        #if DEBUG
        print("* fetchPlaceFromGoogleAPI(): has \(mainViewModel.returnPlaceCount()) places. *")
        #endif
        // If the collection of places isn't empty
        if mainViewModel.returnPlacesCollection().count != 0
        {
            mainViewModel.displayRandomlySelectedPlaceFromCollection(mapView: mapView, marker: marker)
            #if DEBUG
            /*
            for i in mainViewModel.returnPlacesCollection()
            {
                print("-----")
                print("-----")
                print("-----")
                print(i.name + " " + i.placeID + " " + "\(i.types)")
            }
             */
            print("* Collection is NOT empty *")
            #endif
            configureCustomView()
            configureGetDirectionsButton()
        }
    }
}
