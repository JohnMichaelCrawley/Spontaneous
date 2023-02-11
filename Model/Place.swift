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
 Used https://app.quicktype.io to get structs from
 the Google Place API JSON demo here:
 https://developers.google.com/maps/documentation/places/web-service/details#PlaceDetailsResponses
 */
/*
 PLACE:
 This STRUCT is for creating a place object 
 */

struct Place
{
    let placeID: String
    let name: String
    let address: String
    let openingHours: Bool
    let types: [String]
    let rating: Double
    let photoReference: String
    let latitude: Double
    let longitude: Double
}
// MARK: - Result
struct Root: Decodable
{
    let results: [PlaceData]
}
// MARK: - Response
struct PlaceData: Codable
{
    let business_status: String?
    let place_id: String?
    let name: String?
    let rating: Double?
    let formatted_address: String?
    let formatted_phone_number: String?
    let geometry: Geometry?
    let icon: String?
    let openingHours: OpeningHours?
    let photos: [Photo]?
    let types: [String]?
    let user_rating_total: Int?
    let vicinity: String?
    let website: String?
}
// MARK: - Geometry
struct Geometry: Codable
{
    let location: Location
}

// MARK: - Location
struct Location: Codable
{
    let lat, lng: Double
}
// MARK: - OpeningHours
struct OpeningHours: Codable
{
    let openNow: Bool
    enum CodingKeys: String, CodingKey
    {
        case openNow = "open_now"
    }
}
// MARK: - Photo
struct Photo: Codable
{
    let height: Int
    let width: Int
    let htmlAttributions: [String]
    let photoReference: String
    enum CodingKeys: String, CodingKey
    {
        case height
        case width
        case htmlAttributions = "html_attributions"
        case photoReference = "photo_reference"
    }
}
// MARK: - Functions
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



