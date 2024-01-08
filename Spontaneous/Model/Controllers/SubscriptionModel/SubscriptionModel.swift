/*
 Project:           Spontaneous
 File:              SubscriptionModel.swift
 Created:           02/09/2023
 Author:            John Michael Crawley
 
 Description:
 This model creates cases for each product
 tier subscription inside the application
 
*/
// MARK: - Product
enum Product: String, CaseIterable
{
    case basicTier = "Spontaneous.basicTier"
    case travelersEssentialTier = "Spontaneous.travelersEssentialTier"
    case premiumTier = "Spontaneous.premiumTier"
}
