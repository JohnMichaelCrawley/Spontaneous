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
// MARK: - Main View Model 
class MainViewModel
{
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
    //MARK: - Get Random Place (From Array)
    func getRandomPlace() -> Place?
    {
        if PlacesManager.shared.returnPlacesCollection().isEmpty
        {
            return Place?.none
        }
        //myArray.map { String($0) }.joined(separator: ", ")
        let returnedPlacesOutput  = PlacesManager.shared.returnRandomlySelectedPlace()
        return returnedPlacesOutput
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
    
    //MARK: - Return Randomly Selected Keyword
    func returnRandomlySelectedKeyword() -> String
    {
        // if has more than 1 loop
        // else do first item
        return ""
    }
 
}
