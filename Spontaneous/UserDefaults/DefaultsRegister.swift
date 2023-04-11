//
//  DefaultsRegister.swift
//  Spontaneous
//
//  Created by John Michael Crawley on 29/03/2023.
//
/*
 INFORMATION ON THIS STRUCT / FILE:
 This file sets the default values for
 the keys in USERDEFAULTS.
 */

import Foundation
//MARK: - Variables
private let USERDEFAULT = UserDefaults.standard
// Default values when the app loads if new values are not set
private let DEFAULTS =
[
    "applicationTheme": "light",
    "searchRadiusFilter": 0.06213711,
    "pricingFilter": 3,
    "ratingFilter": 3,
    "cafeSwitch": true
] as [String : Any]

//MARK: - Function to set default values
func setUserDefaultsRegister()
{
    USERDEFAULT.register(defaults: DEFAULTS)
}
