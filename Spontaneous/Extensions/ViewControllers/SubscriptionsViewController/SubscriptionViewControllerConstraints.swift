/*
 Project:           Spontaneous
 File:              SubscriptionViewControllerConstraints.swift
 Created:           06/09/2023
 Author:            John Michael Crawley
 
 Description:
 This file sets the constraints for the user interface
 elements; the scrollView, each tiers
 */
// MARK: - Subscription View Controller Extension
extension SubscriptionViewController
{
    //MARK: - Configure Subscription Constraints
    func configureSubscriptionConstraints()
    {
        // Set the constraints for the scrollView
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        // Free Tier
        freeTier.translatesAutoresizingMaskIntoConstraints = false
        freeTier.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.9).isActive = true
        basicTier.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.9).isActive = true
        travelersEssentialTier.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.9).isActive = true
        premiumTier.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.9).isActive = true
        // Assuming tierHeight is a CGFloat representing the desired height
        freeTier.heightAnchor.constraint(equalToConstant: tierHeight).isActive = true
        basicTier.heightAnchor.constraint(equalToConstant: tierHeight).isActive = true
        travelersEssentialTier.heightAnchor.constraint(equalToConstant: tierHeight).isActive = true
        premiumTier.heightAnchor.constraint(equalToConstant: tierHeight).isActive = true
        // Adjust the subscription Tier Stack View
        subscriptionTierStackView.translatesAutoresizingMaskIntoConstraints = false
        // Pin to the leading and trailing edges of the scrollView
        subscriptionTierStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        subscriptionTierStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        // Add top space of 50 points between subscriptionTierStackView and scrollView
        subscriptionTierStackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10 ).isActive = true
        subscriptionTierStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        // Set the width to be equal to the width of the scrollView
        subscriptionTierStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
    }
}
