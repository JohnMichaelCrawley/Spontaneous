//
//  Business.swift
//  Spontaneous
//
//  Created by John Michael Crawley on 31/12/2022.
//

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

let KEY = API().returnAPIKey()
var latitude = USERDEFAULTS.double(forKey: "userLatitude")
var longitude = USERDEFAULTS.double(forKey: "userLongitude")
var radius = 620

var keyword = "cafe"

let url = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=\(latitude),\(longitude)&radius=\(radius)&type=\(keyword)&key=\(KEY)";


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


private func getData(from url: String)
{
    URLSession.shared.dataTask(with: URL(string: url)! ,completionHandler:
        { data, task, error in
        guard let data = data, error == nil else
        {
            print("Something went wrong wih getting the data!...")
            return
        }
        // now we have the data we need to do json decoding
       // var result: SearchResult?
        let jsonDEcoder = JSONDecoder()
        /*
         Try get the random business
         and store it
         */
        do
        {
            // Variables decoder to decode JSON
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let root = try decoder.decode(Root.self, from: data)
            // Get random number from a range of amount of results in JSON
            let range = root.results.count
            var index = 0
            index = Int.random(in: 1..<range)
            // Assign values to global vars
            
            //let business = Business(id: root.results[index].placeId, name: root.results[index].name, type: root.results[index].types, rating: root.results[index].rating, photos: root.results[index].photos, address: root.results[index].vicinity, lat: root.results[index].geometry.location.lat, long: root.results[index].geometry.location.lng)
            
            
            
            /*
            businesssName = root.results[index].name
            businessType = root.results[index].types
            openingHours = root.results[index].openingHours
            placeID = root.results[index].placeId
            vicinity = root.results[index].vicinity
            rating = root.results[index].rating
            businessLatitude = root.results[index].geometry.location.lat
            businessLongitude = root.results[index].geometry.location.lng
           
             */
             // Print values
           // print("business name: \(businesssName) \nTypes: \(businessType) \nOpening Hours: \(String(describing: openingHours)) \nplace ID: \(placeID) \nAddress: \(vicinity) \nRating: \(rating)")
           // print("Lat: \(businessLatitude) \nLong: \(businessLongitude)")
            
            
            
            
        }
        catch
        {
            print(error)
        }
    }).resume()
}
