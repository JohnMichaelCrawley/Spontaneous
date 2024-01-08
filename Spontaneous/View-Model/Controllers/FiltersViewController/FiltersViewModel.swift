/*
 Project:           Spontaneous
 File:              FiltersViewModel.swift
 Created:           04/09/2023
 Author:            John Michael Crawley
 
 Description:
 This view-model is for the filters view
 controller to enable data from the filters
 model to the view. It acts as a middle-man
 */
//MARK: - Import list
import UIKit
import Foundation
// MARK: - Filters View Model
class FiltersViewModel
{
    // MARK: - Variables
    private let userDefaults = UserDefaults.standard
    //MARK: - Rating Slider Value
    var ratingSliderValue: RatingSliderValue
    {
        didSet
        {
            // Save the new rating slider value to UserDefaults
            userDefaults.set(ratingSliderValue.value, forKey: "ratingSliderValue")
        }
    }
    //MARK: - Pricing Slider Value
    var pricingSliderValue: PricingSliderValue
    {
        didSet
        {
            // Save the new pricing slider value to UserDefaults
            userDefaults.set(pricingSliderValue.value, forKey: "pricingSliderValue")
        }
    }
    //MARK: - Radius Slider Value
    var radiusSliderValue: RadiusSliderValue
    {
        didSet
        {
            // Save the new radius slider value to UserDefaults
            userDefaults.set(radiusSliderValue.value, forKey: "radiusSliderValue")
        }
    }
    //MARK: - Init these filter variables above
    init()
    {
        // Check if the keys do not exist in UserDefaults (indicating first launch)
        if userDefaults.value(forKey: "ratingSliderValue") == nil &&
            userDefaults.value(forKey: "pricingSliderValue") == nil &&
            userDefaults.value(forKey: "radiusSliderValue") == nil {
            // This is the first launch of the app
            // Set the initial values
            userDefaults.set(3.0, forKey: "ratingSliderValue")
            userDefaults.set(2.0, forKey: "pricingSliderValue")
            userDefaults.set(0.6213711, forKey: "radiusSliderValue")
        }
        // Initialize the properties
        self.ratingSliderValue = RatingSliderValue(value: userDefaults.float(forKey: "ratingSliderValue"))
        self.pricingSliderValue = PricingSliderValue(value: userDefaults.float(forKey: "pricingSliderValue"))
        self.radiusSliderValue = RadiusSliderValue(value: userDefaults.float(forKey: "radiusSliderValue"))
    }
    
    
    
}
