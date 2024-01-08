/*
 Project:           Spontaneous
 File:              LocationsViewControllerConstraints.swift
 Created:           06/09/2023
 Author:            John Michael Crawley
 
 Description:
 This file handles all the constraints for the user interface
 items in the locations view controller, it also includes the
 view.addSubview() to slightly reduce the code on the main view
*/
//MARK: - Import list
import UIKit
//MARK: - Locations View Controller Extension Table View
extension LocationsViewController
{
    // MARK: - Configure Description Label Constraints and Subview
    func configureDescriptionLabelConstraintsAndSubView()
    {
        // Add label and tableView to the subview
        view.addSubview(locationsDescriptionLabel)
        // Set up constraints for DESCRIPTIONLABEL
        locationsDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            locationsDescriptionLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 110),
            locationsDescriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            locationsDescriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            locationsDescriptionLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 0) // Optional: Adjust the minimum height as needed
        ])
    }
    // MARK: - Configure Locations Table View Constraints and Subview
    func configureLocationsTableViewConstraintsAndSubView()
    {
        view.addSubview(locationsTableView)
        // Set up constraints for tableView below DESCRIPTIONLABEL
        locationsTableView.alwaysBounceVertical = false
        locationsTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            locationsTableView.topAnchor.constraint(equalTo: locationsDescriptionLabel.bottomAnchor, constant: 16), // Adjust the constant as needed
            locationsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            locationsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            locationsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -70)
        ])
        // Add rounded corners
        locationsTableView.layer.cornerRadius = 20
        locationsTableView.layer.masksToBounds = true
    }
}
