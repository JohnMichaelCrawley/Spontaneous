//
//  PlacesManager.swift
//  Spontaneous
//
//  Created by John Crawley on 16/10/2023.
//
//MARK: - Import List
import Foundation
// MARK: - Place Manager
class PlacesManager
{
    // MARK: - Variables
    static  let shared = PlacesManager()
    private var places = [Place]()
    private var boolUserDefaultsKeys: [String] = []
    // private let randomlySelectedPlace: Place
    

    //MARK: - Find UI Switches Turned On
    func findUILocationSwitchesTurnedOn() -> [String]
    {
        // Get all UserDefaults entries
          let allUserDefaults = UserDefaults.standard.dictionaryRepresentation()

          // Filter entries that contain "Switch" in the key and are bool variables turned on
        // If found remove the prefix of the "switch"
          let turnedOnSwitches = allUserDefaults.compactMap { key, value -> String? in
              guard key.hasSuffix("Switch"), let boolValue = value as? Bool, boolValue else {
                  return nil
              }
              return key.replacingOccurrences(of: "Switch", with: "")
          }
          return turnedOnSwitches
    }
    //MARK: - Append Place To Collection Array
    func appendPlaceToCollection(place: Place)
    {
            places.append(place)
    }
    //MARK: - Return Place Collections Count
    func returnPlacesCollectionCount() -> Int
    {
        return places.count
    }
    //MARK: - Return Places
    func returnPlacesCollection() -> [Place]
    {
        return places
    }
    //MARK: - Initialize Bool User Default sKeys
    func initializeBoolUserDefaultsKeys()
    {
        // Get the UserDefaults
        let userDefaults = UserDefaults.standard
        // Retrieve all keys from UserDefaults
        let allKeys = userDefaults.dictionaryRepresentation().keys
        
        // Filter the keys to get only the boolean keys that are turned on
        boolUserDefaultsKeys = allKeys.compactMap { (key) -> String? in
            if userDefaults.bool(forKey: key) 
            {
                return key
            }
            return nil
        }
    }
    //MARK: - Shuffle Array (Fisher-Yates Algorithm)
    private func shuffleArray<T>(_ array: [T]) -> [T]
    {
        var shuffledArray = array
        for i in (0..<shuffledArray.count).reversed()
        {
            let j = Int.random(in: 0...i)
            if i != j
            {
                shuffledArray.swapAt(i, j)
            }
        }
        return shuffledArray
    }
    //MARK: - Return Randomly Selected Place
    func returnRandomlySelectedPlace() -> Place
    {
        initializeBoolUserDefaultsKeys() 
        
        let shuffledPlaces = shuffleArray(places)
        return shuffledPlaces.first!
    }
}
