/*
 Project:           Spontaneous
 File:              FiltersViewControllerSliders.swift
 Created:           02/10/2023
 Author:            John Michael Crawley
 
 Description:
 This file handles the sliders values and labels
 for the Filters view
 */
//MARK: - Import list
import UIKit
//MARK: - Extension Filters View Controller - Sliders
extension FiltersViewController
{
    //MARK: - Rating Slider Value Changed
    @objc func ratingSliderValueChanged(_ sender: UISlider)
    {
        filtersViewModel.ratingSliderValue.value = sender.value
        updateSliderLabels()
    }
    //MARK: - Pricing Slider Value Changed
    @objc func pricingSliderValueChanged(_ sender: UISlider)
    {
        filtersViewModel.pricingSliderValue.value = sender.value
        updateSliderLabels()
    }
    //MARK: - Search Radius Slider Value Changed
    @objc func searchRadiusSliderValueChanged(_ sender: UISlider)
    {
        filtersViewModel.radiusSliderValue.value = sender.value
        updateSliderLabels()
    }
}
