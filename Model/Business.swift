//
//  Business.swift
//  Spontaneous
//
//  Created by John Michael Crawley on 31/12/2022.
//

import Foundation

// USER DEFAULTS
let USERDEFAULTS = UserDefaults.standard



//Required parameters
/*
 Required parameters:
 * lat' and long to gather place information = This is used for getting the user's location and finding places around the user
 * Radius = Radius defines the distance in meters which returns place results. The mazimum allowed radius is 5000 meters
 * Keyword = Search term or keyword which should match against all content that google has indexed for this place.
 */

var latitude = USERDEFAULTS.
var longitude = -6.259353
var radius = 620

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
/*
