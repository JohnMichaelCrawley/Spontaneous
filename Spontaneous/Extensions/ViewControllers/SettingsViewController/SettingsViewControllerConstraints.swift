/*
 Project:           Spontaneous
 File:              SettingsViewControllerConstraints.swift
 Created:           06/09/2023
 Author:            John Michael Crawley
 
 Description:
 This file handles all the constraints inside the settings
 view controller for all the user interface elements
*/
//MARK: - Import List
import UIKit
// MARK: - Settings View Controller Extension - Constraints
extension SettingsViewController
{
    //MARK: - Configure Settings Table View Constraints
    func configureSettingsTableViewConstraints()
    {
        // Set up Auto Layout constraints
        settingsTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            settingsTableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            settingsTableView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            settingsTableView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1.0),
            settingsTableView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1.0)
        ])
    }
    //MARK: - Configure Version Label Constraints
    func configureVersionLabelConstraints()
    {
        // Create Auto Layout constraints
        versionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        versionLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        versionLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        versionLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
}
