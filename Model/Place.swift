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
/*
 Used https://app.quicktype.io to get structs from
 the Google Place API JSON demo here:
 https://developers.google.com/maps/documentation/places/web-service/details#PlaceDetailsResponses
 */
/*
 PLACE:
 This STRUCT is for creating a place object 
 */

// MARK: - PLACE
struct Place
{
    let placeID: String
    let name: String
    let address: String
    let isOpenNow: Bool
    let types: [String]
    let rating: Double
  //  let photoReference: String
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
    let opening_hours: OpeningHours?
    let photos: [Photo]?
    let types: [String]?
    let user_rating_total: Int?
    let vicinity: String?
    let website: String?
    let price_level: Int?
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
    let open_now: Bool
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
