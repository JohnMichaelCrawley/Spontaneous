/*
 Project:           Spontaneous
 File:              UsageViewControllerConfigure.swift
 Created:           04/09/2023
 Author:            John Michael Crawley
 
 Description:
 Set up the circular progress bar and add it to the
 view controller
 */
// MARK: - Import List
import UIKit

// MARK: - Usage View Controller Extension
extension UsageViewController
{
    //MARK: - Set Up Circular Progress Bar View
    func configureCircularProgressBarView() 
    {
        // Set up the containerView
        containerView.backgroundColor = .systemBackground
        containerView.layer.cornerRadius = 25
        containerView.clipsToBounds = true
        view.addSubview(containerView)
        // Set up the Usage Title label
        containerView.addSubview(UsageLabel)
        // Set up the circularView
        containerView.addSubview(circularView)
        // Add constraints
        configureUsageUserInterfaceConstraints()
        // Call the progress animation method
        circularView.progressAnimation(duration: 100, stopPercentage: 0.75)
    }
}
