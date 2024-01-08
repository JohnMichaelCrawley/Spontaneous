/*
 Project:           Spontaneous
 File:              LanguagesViewControllerConstraints.swift
 Created:           06/09/2023
 Author:            John Michael Crawley
 
 Description:
 This file sets the constraints for the table view
 and the description for the language selection. 
 */
//MARK: - Import List
import UIKit
//MARK: - Languages View Controller Extension - Constraints
extension LanguagesViewController
{
    // MARK: - Configure Languages Constraints and Subview
    func configureLanguagesTableViewConstraintsAndSubview()
    {
        view.addSubview(languagesTableView)
        languagesTableView.alwaysBounceVertical = false
        NSLayoutConstraint.activate([
            languagesTableView.widthAnchor.constraint(equalToConstant: 350),
            languagesTableView.heightAnchor.constraint(equalToConstant: 240),
            languagesTableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            languagesTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80)
        ])
        // Set corner radius to round the corners
        languagesTableView.layer.cornerRadius = 25 // Adjust the value as needed
        languagesTableView.layer.masksToBounds = true
    }
    // MARK: - Configure Language Description Label Constraints and Subview
    func configureLanguageDescriptionLabelConstraintsAndSubview()
    {
        // Position the label above the tableView with a vertical spacing of 30
        view.addSubview(languageDescriptonLabel)
        languageDescriptonLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            languageDescriptonLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20), // Adjust the leading spacing as needed
            languageDescriptonLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20), // Adjust the trailing spacing as needed
            languageDescriptonLabel.bottomAnchor.constraint(equalTo: languagesTableView.topAnchor, constant: -30), // Adjust the vertical spacing as needed
        ])
    }
    
}
