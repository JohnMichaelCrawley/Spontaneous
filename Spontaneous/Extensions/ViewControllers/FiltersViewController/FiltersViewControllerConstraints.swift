/*
 Project:           Spontaneous
 File:              FiltersViewControllerConstraints.swift
 Created:           04/09/2023
 Author:            John Michael Crawley
 
 Description:
 This file configures the constraints for the filters
 stack view.
 */

// MARK: - Import List
import UIKit
// MARK: - Filters View Controller Extension - Constraints
extension FiltersViewController
{
    //MARK: - Configure StackView Constraints
    func configureFilterStackViewConstraints()
    {
        // Set constraints for the stack view
        filtersStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            filtersStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            filtersStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            filtersStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        // Set width constraints for subviews
        let subviewWidthMultiplier: CGFloat = 0.9
        rating.widthAnchor.constraint(equalTo: filtersStackView.widthAnchor, multiplier: subviewWidthMultiplier).isActive = true
        pricing.widthAnchor.constraint(equalTo: filtersStackView.widthAnchor, multiplier: subviewWidthMultiplier).isActive = true
        searchRadius.widthAnchor.constraint(equalTo: filtersStackView.widthAnchor, multiplier: subviewWidthMultiplier).isActive = true
        // Adjust the height Anchor
        rating.heightAnchor.constraint(equalToConstant: 180).isActive = true
        pricing.heightAnchor.constraint(equalToConstant: 180).isActive = true
        searchRadius.heightAnchor.constraint(equalToConstant: 180).isActive = true
    }
}
