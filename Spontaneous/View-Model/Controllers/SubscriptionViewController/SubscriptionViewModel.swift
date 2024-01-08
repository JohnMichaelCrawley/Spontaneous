/*
 Project:           Spontaneous
 File:              SubscriptionViewModel.swift
 Created:           04/09/2023
 Author:            John Michael Crawley
 
 Description:
 This view-model is for the subscription view
 controller to enable data from the subscription
 model to the view. It acts as a middle-man
 */
// MARK: - Import List
import Foundation
import StoreKit
// MARK: - Subscription View Model
class SubscriptionViewModel
{
    // MARK: - Variables
    var subscriptionModels = [SKProduct]()
    // MARK: - Return Product Identifier
    func returnAddPaymentToProduct(identifier: String) 
    {
        #if DEBUG
        print("Searching for product with identifier: \(identifier)")
        // Print the contents of subscriptionModels for debugging
        print("Subscription Models: \(subscriptionModels)")
        #endif
        // Find the corresponding SKProduct for the given productIdentifier
        if let selectedProduct = subscriptionModels.first(where: { $0.productIdentifier == identifier }) 
        {
            let payment = SKPayment(product: selectedProduct)
            SKPaymentQueue.default().add(payment)
        } 
        else
        {
            #if DEBUG
            // Handle the case where the productIdentifier does not match any product in subscriptionModels
            print("Product with identifier '\(identifier)' not found.")
            #endif
        }
    }  
}
