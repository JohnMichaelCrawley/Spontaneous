/*
 Project:           Spontaneous
 File:              SubscriptionViewController.swift
 Created:           01/09/2023
 Author:            John Michael Crawley
 
 Description:
 This view controller handles what tier
 subscription that the user has selected.
 In this view controller the end-user can
 select what tier of subscription they want.
 */
//Import List
import UIKit
import StoreKit
// MARK: - Subscription View Controller
class SubscriptionViewController: UIViewController
{
    // MARK: - Selected Subscription Tier Product
    var selectedSubscriptionTier: Product?    
    // MARK: - View Model
    let subscriptionViewModel = SubscriptionViewModel()
    // MARK: - Store Kit
    //MARK: - User Interface
    let scrollView = UIScrollView()
    let subscriptionTierStackView = UIStackView()
    //MARK: -  Set up constraints for the SubscriptionTiers objects
    let tierWidth: CGFloat = 100.0 // Adjust the width as needed
    let tierHeight: CGFloat = 350.0 // Adjust the height as needed
    //MARK: - Subscription Tiers
    let freeTier = SubscriptionTiers()
    let basicTier = SubscriptionTiers()
    let travellersEssentialTier = SubscriptionTiers()
    let premiumTier = SubscriptionTiers()
    // MARK: - Tier Colours
    let freeColour = UIColor(red: 65/255, green: 150/255, blue: 145/255, alpha: 1.0)        // #419691
    let basicColour = UIColor(red: 80/255, green: 180/255, blue: 175/255, alpha: 1.0)       // #50B4AF
    let travelersColour = UIColor(red: 50/255, green: 160/255,blue: 155/255, alpha: 1.0)    // #32A09B
    let premiumColour = UIColor(red: 100/255, green: 215/255, blue: 190/255, alpha: 1.0)    // #64D7BE

    // MARK: - View Did Load
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Configure the navigation top bar
        self.title = "Subscription"
        // Add the scrollView to the main view
        view.addSubview(scrollView)
        // Configure stack
        subscriptionTierStackView.axis = .vertical
        subscriptionTierStackView.alignment = .center
        subscriptionTierStackView.distribution = .fill
        subscriptionTierStackView.spacing = 10
        // Configure Tiers and add subview
        configureTiersToStackView()
        configureTiersAndAddSubview()
        // Configure the constraints
        configureSubscriptionConstraints()
        // Fetch the subsription products
        
        
        
        fetchProducts()
        
        
    }
    //MARK: - View Will Appear
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
         showNavigationBar(animated: animated)
       // hideNavigationBottomTabBar(animated: animated)
    }
    //MARK: - View Will Disappear
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
       // hideNavigationBar(animated: true)
    }
    
    // MARK: - Deinit for Payment
    deinit
    {
        // Remove the observer when the view controller is deallocated
        SKPaymentQueue.default().remove(self)
    }
    
}
