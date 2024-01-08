/*
 Project:           Spontaneous
 File:              FiltersViewControllerConstraints.swift
 Created:           06/09/2023
 Author:            John Michael Crawley
 
 Description:
 This file configures all the information for the filters
 in the filters group and applying the filters to a stack
 view and creating rounded corners on the filters
 stack view items.
 */

// MARK: - Import List
import UIKit
// MARK: - Filters View Controller Extension - Configure
extension FiltersViewController
{
    //MARK: - Configure Filters
    func configureFiltersGroupDetails()
    {
        // Configure the Filters
        rating.configure(title: "Rating", description: "Filtering the rating will filter the search specifically and try to find a rating on your selection", value: "5 Stars", sliderValue: 3)
        pricing.configure(title: "Pricing", description: "Filtering the pricing will search for the price range you want. The price range is €-€€€", value: "€€€", sliderValue: 2)
        searchRadius.configure(title: "Search Radius", description: "Filtering the radius will only filter the search to how big the search will be around your location", value: "1 Mile", sliderValue: 0.5)
        applyFiltersToStackView()
    }
    
    //MARK: - Configure Filter Sliders 
    func configureSliderValues()
    {
        // Rating Values
        rating.configureSliderMinimum(min: 1)
        rating.configureSliderMaximum(max: 5)
        // Pricing Values
        pricing.configureSliderMinimum(min: 1)
        pricing.configureSliderMaximum(max: 3)
        // Search Radius
        searchRadius.configureSliderMinimum(min: 0.2)
        searchRadius.configureSliderMaximum(max: 1)
    }
    //MARK: - Set Slider Values From User Defaults
    func setSliderValuesFromUserDefaults()
    {
        rating.configureSliderValue(sliderValue: UserDefaults.standard.float(forKey: "ratingSliderValue"))
        pricing.configureSliderValue(sliderValue: UserDefaults.standard.float(forKey: "pricingSliderValue"))
        searchRadius.configureSliderValue(sliderValue: UserDefaults.standard.float(forKey: "radiusSliderValue"))
    }
    //MARK: - Update Slider Labels in the filters
    func updateSliderLabels()
    {
        // Update the RATING label values
        var baseRatingValue = String(format: "%.1f", UserDefaults.standard.float(forKey: "ratingSliderValue"))
        baseRatingValue = baseRatingValue.replacingOccurrences(of: ".00", with: "").replacingOccurrences(of: ".0", with: "")
       rating.updateFilterLabel(updateValueLabel: baseRatingValue + " stars")
        // Update the PRICING label values
        let pricingValue = Int(UserDefaults.standard.float(forKey: "pricingSliderValue"))
        switch pricingValue
        {
        case 1:
            pricing.updateFilterLabel(updateValueLabel: "€")
        case 2:
            pricing.updateFilterLabel(updateValueLabel: "€€")
        case 3:
            pricing.updateFilterLabel(updateValueLabel: "€€€")
        default:
            pricing.updateFilterLabel(updateValueLabel: "€")
        }
        // Update the SEARCH RADIUS label values
        var baseRadiusValue = String(format: "%.1f", UserDefaults.standard.float(forKey: "radiusSliderValue"))
        baseRadiusValue = baseRadiusValue.replacingOccurrences(of: ".00", with: "").replacingOccurrences(of: ".0", with: "")
        searchRadius.updateFilterLabel(updateValueLabel: baseRadiusValue + " miles")
    }
    //MARK: - Add Filters To StackView
    func applyFiltersToStackView()
    {
        // Add the filter UI Group to the stack
        filtersStackView.addArrangedSubview(rating)
        filtersStackView.addArrangedSubview(pricing)
        filtersStackView.addArrangedSubview(searchRadius)
    }
    //MARK: - Configure Corner Radius for each subview in the stack
    func configureSubStackRadius()
    {
        // Set corner radius for all subviews
        for subview in filtersStackView.arrangedSubviews
        {
            subview.layer.cornerRadius = 25 // Adjust the value as needed
            subview.layer.masksToBounds = true
        }
    }
}

