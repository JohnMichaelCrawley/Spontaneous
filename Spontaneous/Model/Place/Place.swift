/*
 Project:           Spontaneous
 File:              Place.swift
 Created:           16/10/2023
 Author:            John Michael Crawley
 
 Description:
 This file is for creating the struct for help
 storing Google Place data
 */
//MARK: - Import list
import Foundation
// MARK: - PLACE
struct Place
{
    let placeID: String
    let name: String
    let address: String
    let isOpenNow: Bool
    let types: [String]
    let rating: Double
    let pricingRange: Int
  //  let photoReference: String
    let photo: [Photo]
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
