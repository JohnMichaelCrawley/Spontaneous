//
//  Business.swift
//  Spontaneous
//
//  Created by John Michael Crawley on 31/12/2022.
//
/*
 INFORMATION ON THIS STRUCT / FILE:
 This file uses structs to create value
 types for storing the data from Google's API
 that can be used to make
 */

import Foundation
import GoogleMaps
import GoogleMapsBase
import GoogleMapsCore

// USER DEFAULTS
let USERDEFAULTS = UserDefaults.standard
//Required parameters
/*
 Required parameters:
 * lat' and long to gather place information = This is used for getting the user's location and finding places around the user
 * Radius = Radius defines the distance in meters which returns place results. The mazimum allowed radius is 5000 meters
 * Keyword = Search term or keyword which should match against all content that google has indexed for this place.
 */
/*
 BUSINESS:
 this struct sets, gets
 data for the business
 */
struct Business
{
    // Variables for data on the business
    private var id: String                      // Place ID
    private var name: String                    // Business Name
    private var type: [String]                  // Type of Business
    private var openingHours: [String: Bool]?
    private var rating: Double                  // Business Rating
    // Photo data
  //  private var photos: [Photo]
    // Variables for location
    private var address: String                 // Business Address / Vicinity
    private var lat: Double                     // Latitude for the business
    private var long: Double                    // longitude for the business
    
    init()
    {
        self.id = ""
        self.name = ""
        self.type = ["", ""]
        self.openingHours = [:]
        self.rating = 0.0
      //  self.photos = []
        self.address = ""
        self.lat = 0.0
        self.long = 0.0
    }
    
    
    
    /*
     "id": id,
     "name": name,
     "type": type,
     "openingHours": openingHours!,
     "rating": rating,
     "address": address,
     "lat": lat,
     "lng": long
             
     */
        
    
  

    // INIT
    /*init(id: String, name: String, type: [String], openingHours: [String : Bool]? = nil, rating: Double, photos: [Photo], address: String, lat: Double, long: Double) {
        self.id = id
        self.name = name
        self.type = type
        self.openingHours = openingHours
        self.rating = rating
        self.photos = photos
        self.address = address
        self.lat = lat
        self.long = long
    }
     */
     
    // SETTERS
    mutating func setBusinessID(ID: String)
    {
        self.id = ID
    }
    mutating func setBusinessName(name: String)
    {
        self.name = name
    }
    mutating func setBusinessType(type: [String])
    {
        self.type = type
    }
    mutating func setBusinessOpeningHours(openingHours: [String: Bool])
    {
        self.openingHours = openingHours
    }
    mutating func setBusinessRating(rating: Double)
    {
        self.rating = rating
    }
   /* mutating func setBusinessPhotos(photos: [Photo])
    {
        self.photos = photos
    }
    */
    mutating func setBusinessAddress(vicinity: String)
    {
        self.address = vicinity
    }
    mutating func setBusinessLatitude(lat: Double)
    {
        self.lat = lat
    }
    mutating func setBusinessLongitude(lng: Double)
    {
        self.long = lng
    }
    // GETTERS
    func getBusinessID () -> String
    {
        return id
    }
    func getBusinessName () -> String
    {
        return name
    }
    func getBusinessType () -> [String]
    {
        return type
    }
    func getBusinessOpeningHours () -> [String: Bool]?
    {
        return openingHours
    }
    func getBusinessRating () -> Double
    {
        return rating
    }
    /*
    func getBusinessPhotos () -> [Photo]
    {
        return photos
    }*/
    func getBusinessAddress () -> String
    {
        return address
    }
    func getBusinessLat () -> Double
    {
        return lat
    }
    func getBusinessLong () -> Double
    {
        return long
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
    func getRandomLocation() -> String
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
                print("element = \(element)")
                #endif
                keywords.append(element)
            }
        }
        keyword = keywords.randomElement()!
        return keyword
    }

}





/*
 Function to shuffle and completely
 randomise the elements
 */
func fisherYatesShuffle()
{
    
}




/*
These structs are used to help
 with decoding and enabling access
 to the JSON data for Google Map / Places
 */
struct Root: Codable {
    var results: [SearchResult]
    var status: String
}
struct SearchResult: Codable {
   // var id: Int
    var icon: String
    var name: String
    var rating: Double
    var placeId: String
    var reference: String
    var types: [String]
    var vicinity: String
    var geometry: Geometry
    var photos: [Photo]
    var openingHours: [String:Bool]?
}
struct Geometry: Codable  {
    var location: Location
}
struct Location: Codable  {
    var lat: Double
    var lng: Double
}
struct Photo: Codable {
    var height: Double
    var width: Double
    var photoReference: String
}



extension String {
    func deletingPrefix(_ prefix: String) -> String {
        guard self.hasPrefix(prefix) else { return self }
        return String(self.dropFirst(prefix.count))
    }
}
