/*
 Project:           Spontaneous
 File:              CreditssViewControllerConstraints.swift
 Created:           06/09/2023
 Author:            John Michael Crawley
 
 Description:
 This file sets up the constraints for the credits
 table view
 */
//MARK: - Import List
import UIKit
//MARK: - Credits View Controller Extension - Constraints
extension CreditsViewController 
{
    // MARK: - Configure Credits Table View Constraints And Subview
    func configureCreditsTableViewConstraintsAndAddSubview() 
    {
        view.addSubview(creditsTableView)
        creditsTableView.translatesAutoresizingMaskIntoConstraints = false
        
        // Set up Auto Layout constraints to fit the screen
        NSLayoutConstraint.activate([
            creditsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            creditsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            creditsTableView.topAnchor.constraint(equalTo: view.topAnchor),
            creditsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        creditsTableView.alwaysBounceVertical = false // Turn off scroll for tableView
    }
}
