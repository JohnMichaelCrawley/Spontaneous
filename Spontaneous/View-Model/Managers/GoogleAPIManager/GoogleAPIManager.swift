//
//  GoogleAPIManager.swift
//  Spontaneous
//
//  Created by John Crawley on 17/10/2023.
//

import Foundation

class GoogleAPIManager
{
    //MARK: - Variables
    static let shared = GoogleAPIManager()
    private let APIKEY = ""
    //MARK: - Return API Key
    func returnAPIKey() -> String
    {
        return APIKEY
    }
}
