/*
 Project:           Spontaneous
 File:              UserDefaultsRegister.swift
 Created:           24/08/2023
 Author:            John Michael Crawley
 
 Description:
 This file handles the creation of default values
 for the settings in the application. It sets default
 values and when the user chances the settings, it will
 ignore this and use the values set in user defaults.
 
*/
//MARK: - Import List
import Foundation
//MARK: - Variables
private let USERDEFAULT = UserDefaults.standard
// Default values when the app loads if new values are not set
private let DEFAULTS =
[
    // Settings Menu
    "themeMode": false,             // false = light mode | true = dark mode
    "SelectedLanguageIndex": 0,     // 0 = English which is the default language of the app
    "cafeSwitch": true,             //
    "cinemaSwitch": true            //
] as [String : Any]

//MARK: - Function to set default values
func setUserDefaultsRegister()
{
    USERDEFAULT.register(defaults: DEFAULTS)
    USERDEFAULT.synchronize()
}
