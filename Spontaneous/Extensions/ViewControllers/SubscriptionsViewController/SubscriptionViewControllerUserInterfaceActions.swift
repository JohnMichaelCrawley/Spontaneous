/*
 Project:           Spontaneous
 File:              SubscriptionViewControllerUserInterfaceActions.swift
 Created:           02/09/2023
 Author:            John Michael Crawley
 
 Description:
 This file manages the buttons pressed for each tiers and loads up
 the payment option for each 
 */
// MARK: - Import List
import UIKit
// MARK: - Subscription View Controller Extension
extension SubscriptionViewController
{
    //MARK: - Basic Subscribe Button Pressed
    @objc func basicSubscribeButtonPressed(_ sender: UIButton)
    {
        let basicTierProductId = Product.basicTier.rawValue
        subscriptionViewModel.returnAddPaymentToProduct(identifier: basicTierProductId)
        

        
        selectedSubscriptionTier = .basicTier
      //  configureSubscribeButtonTitles()
    }
    //MARK: - Travelers Essential Subscribe Button Pressed
    @objc func travelersEssentialSubscribeButtonPressed(_ sender: UIButton)
    {
        let travelersEssentialTierProductId = Product.travelersEssentialTier.rawValue
        subscriptionViewModel.returnAddPaymentToProduct(identifier: travelersEssentialTierProductId)

        
        selectedSubscriptionTier = .travelersEssentialTier
        // Update UI, e.g., change button titles
       // configureSubscribeButtonTitles()
    }
    //MARK: - Premium Subscribe Button Pressed
    @objc func premiumSubscribeButtonPressed(_ sender: UIButton)
    {
        let premiumTierProductId = Product.premiumTier.rawValue
        subscriptionViewModel.returnAddPaymentToProduct(identifier: premiumTierProductId)
        

        
        selectedSubscriptionTier = .premiumTier
        // Update UI, e.g., change button titles
      //  configureSubscribeButtonTitles()
    }
}
