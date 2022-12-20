//
//  API.swift
//  Spontaneous
//
//  Created by John Michael Crawley on 13/12/2022.
//

import Foundation

/*
 API struct:
 this struct holds the API token key
 that is needed in the application
 to get access to Google's API
 */

struct API
{
    // Variable to hold the API token key
    private let TOKEN: String = ""
    // Return the API Key value //
    func returnAPIKey() -> String
    {
        return TOKEN
    }
}
