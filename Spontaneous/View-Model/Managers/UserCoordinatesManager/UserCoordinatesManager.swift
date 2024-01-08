//
//  UserCoordinatesManager.swift
//  Spontaneous
//
//  Created by John Crawley on 13/10/2023.
//



/*
 Project:           Spontaneous
 File:              GoogleMapManager.swift
 Created:           13/10/2023
 Author:            John Michael Crawley
 
 Description:
 This file handles a shared user coordinates to be
 accessed or used through the app' and uses D.R.Y
 principles to avoid repetition.
*/
//MARK: - Imports
import Foundation
//MARK: - User Coordinate Manager
class UserCoordinatesManager
{
    //MARK: - Shared
    static let shared = UserCoordinatesManager()
    // MARK: - User Coordinates
    private var userCoordinates: UserCoordinates?
    //MARK: - INIT
    private init(userCoordinates: UserCoordinates? = nil)
    {
        self.userCoordinates = userCoordinates
    }
    // Function to set user coordinates
    //MARK: - Set User Coordinates
    func setUserCoordinates(latitude: Double, longitude: Double)
    {
        userCoordinates = UserCoordinates(latitude: latitude, longitude: longitude)
    }
    // Function to get user coordinates
    //MARK: - Get User Coordinates
    func getUserCoordinates() -> UserCoordinates?
    {
        return userCoordinates
    }
    
}
