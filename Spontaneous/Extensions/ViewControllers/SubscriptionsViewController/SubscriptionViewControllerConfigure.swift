/*
 Project:           Spontaneous
 File:              SubscriptionViewControllerConfigure.swift
 Created:           06/09/2023
 Author:            John Michael Crawley
 
 Description:
 This file configure the data for each tier and adds the tiers
 to the subView and configures the rounded corners of
 the stack view items
 */
// MARK: - Subscription View Controller Extension

import UIKit
extension SubscriptionViewController
{
    //MARK: - Configure Tiers and Add Subview
    func configureTiersAndAddSubview()
    {
        // Configure all the tiers objects
        // Free
        freeTier.setTierLabels(title: "Free", description: "As a free user, you get 5 Spontaneous searches by default through the app per month.", pricing: "$0", subDescription: "This tier is completely free and doesn't require any payment.")
        freeTier.setTierStackBackgroundColour(backgroundColour: .secondarySystemBackground )
        freeTier.setBorderColor(borderColor: freeColour)
        freeTier.setSubscribeButtonTitle("")
        
        
        //Basic
        basicTier.setTierLabels(title: "Basic", description: "Basics users unlock 100 Spontaneous searches through the app. This is more tailored to users who do the odd spontaneous thing. ", pricing: "$0.99/Month", subDescription: "This subscription is auto-renewal")
        basicTier.setSubscribeButtonTarget(target: self, action: #selector(basicSubscribeButtonPressed(_:)), for: .touchUpInside)
        basicTier.setBorderColor(borderColor: basicColour)
        basicTier.setTierStackBackgroundColour(backgroundColour: .secondarySystemBackground)
        
        
        
        // Traveler's Esssential
        travelersEssentialTier.setTierLabels(title: "Traveler's Essential", description: "Traveler's essential allows people who regualarly travel and want to get the most out of it by getting 200 Spontaneous searches through the app", pricing: "$2.99/Month", subDescription: "This subscription is auto-renewal")
        travelersEssentialTier.setTierStackBackgroundColour(backgroundColour: .secondarySystemBackground)
        travelersEssentialTier.setBorderColor(borderColor: travelersColour)
        travelersEssentialTier.setSubscribeButtonTarget(target: self, action: #selector(travelersEssentialSubscribeButtonPressed(_:)), for: .touchUpInside)
        
        
        
        // Premium
        premiumTier.setTierLabels(title: "Premium", description: "With premium, you unlock the most amount of Spontaneous searchs by getting 1,000 Spontaneous searches through the app per month", pricing: "$10.00/Month", subDescription: "This subscription is auto-renewal")
        premiumTier.setBorderColor(borderColor: premiumColour)
        premiumTier.setTierStackBackgroundColour(backgroundColour: .secondarySystemBackground)
        premiumTier.setSubscribeButtonTarget(target: self, action: #selector(premiumSubscribeButtonPressed(_:)), for: .touchUpInside)
        // Add the tiers stack view to the scroll view
        scrollView.addSubview(subscriptionTierStackView)
    }
    // MARK: - Configure Tiers To Stackview
    func configureTiersToStackView()
    {
        // Add all the subscription tiers to the stack
        subscriptionTierStackView.addArrangedSubview(freeTier)
        subscriptionTierStackView.addArrangedSubview(basicTier)
        subscriptionTierStackView.addArrangedSubview(travelersEssentialTier)
        subscriptionTierStackView.addArrangedSubview(premiumTier)
        configureTierSubStackStyle()
    }
    // MARK: - Configure Tier Substack Style
    func configureTierSubStackStyle()
    {
        // Set corner radius for all subviews
        for subview in subscriptionTierStackView.arrangedSubviews
        {
            subview.layer.cornerRadius = 25 // Adjust the value as needed
            subview.layer.masksToBounds = true
        }
    }
    
    
    
    
    
    
    
    

    

    
    
    
   
    
    
    
}
