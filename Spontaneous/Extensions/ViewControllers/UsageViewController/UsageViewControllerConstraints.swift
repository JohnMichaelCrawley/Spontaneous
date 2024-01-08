/*
 Project:           Spontaneous
 File:              UsageViewControllerConstraints.swift
 Created:           06/09/2023
 Author:            John Michael Crawley
 
 Description:
 Configure the constraints for the user interface
 element son the usage view controller
 */
// MARK: - Import List
import UIKit
// MARK: - Usage View Controller Extension - Constraints
extension UsageViewController
{
    // MARK: - Configure Usage UI Constraints
    func configureUsageUserInterfaceConstraints()
    {
        // Container View Constraints
          containerView.translatesAutoresizingMaskIntoConstraints = false

          // Add constraints to center the containerView vertically within the main view and set its height
          NSLayoutConstraint.activate([
              containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
              containerView.heightAnchor.constraint(equalToConstant: containerViewHeight)
          ])

          // Leading and trailing constraints for the containerView
          containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
          containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true

          // Label constraint
          UsageLabel.translatesAutoresizingMaskIntoConstraints = false

          NSLayoutConstraint.activate([
              UsageLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10), // Adjust the top spacing as needed
              UsageLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
              UsageLabel.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.8), // Adjust the width as needed
          ])

          // Circular view constraint
        // Circular view constraint
        circularView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            circularView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            circularView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            circularView.widthAnchor.constraint(equalToConstant: circularViewSize),
            circularView.heightAnchor.constraint(equalToConstant: circularViewSize)
        ])
    }
}
