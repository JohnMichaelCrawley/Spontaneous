/*
 Project:           Spontaneous
 File:              SubscriptionTiers.swift
 Created:           01/09/2023
 Author:            John Michael Crawley
 
 Description:
 This file creates reusuable code for adding
 tier pricing and plans into a stackView to
 be displayed into the Subscription view
 controller.
 
*/
// MARK: - Import List
import UIKit
// MARK: - Subscription Tiers
class SubscriptionTiers: UIView
{
    // MARK: - Uuser Interface Variables
    private let stackView = UIStackView()
    private let tierTitleLabel = UILabel()
    private let tierDescriptionLabel = UILabel()
    private let pricingLabel = UILabel()
    private let subDescriptionLabel = UILabel()
    private let subscribeButton = UIButton()
    // Default background color
    private var tierStackBackgroundColour: UIColor = UIColor.gray
    // MARK: - Initialization
    override init(frame: CGRect) 
    {
        super.init(frame: frame)
        setupTierStack()
    }
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        setupTierStack()
    }
    // MARK: - Private Methods
    private func setupTierStack() 
    {
        //Configure U.I
        // TIERSTACK
        // Configure UI
        // TITLE
        tierTitleLabel.font = UIFont.boldSystemFont(ofSize: 27)
        tierTitleLabel.textColor = UIColor.label
        tierTitleLabel.translatesAutoresizingMaskIntoConstraints = false // Enable Auto Layout for the title label
        // DESCRIPTION
        tierDescriptionLabel.font = UIFont.systemFont(ofSize: 14)
        tierDescriptionLabel.textAlignment = .justified
        tierDescriptionLabel.textColor = UIColor.label
        tierDescriptionLabel.numberOfLines = 0
        tierDescriptionLabel.preferredMaxLayoutWidth = stackView.bounds.size.width
        tierDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false // Enable Auto Layout for the description label
        // PRICING
        pricingLabel.font = UIFont.systemFont(ofSize: 29)
        pricingLabel.textColor = UIColor.label
        pricingLabel.translatesAutoresizingMaskIntoConstraints = false // Enable Auto Layout for the pricing label
        // SUB-DESC
        subDescriptionLabel.font = UIFont.systemFont(ofSize: 12)
        subDescriptionLabel.textColor = UIColor.label
        subDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false // Enable Auto Layout for the sub-description label
        // Configure stack view
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false // Enable Auto Layout for the stack view
        // Configure button
        subscribeButton.setTitle("Subscribe", for: .normal)
        subscribeButton.setTitleColor(UIColor.label, for: .normal)
        subscribeButton.translatesAutoresizingMaskIntoConstraints = false // Enable Auto Layout for the subscribe button
        // Add labels and button to the stack view
        stackView.addArrangedSubview(tierTitleLabel)
        stackView.addArrangedSubview(tierDescriptionLabel)
        stackView.addArrangedSubview(pricingLabel)
        stackView.addArrangedSubview(subDescriptionLabel)
        stackView.addArrangedSubview(subscribeButton)
        // Add the stack view to the custom view
        addSubview(stackView)
        // Set the background color
        backgroundColor = tierStackBackgroundColour
        // Create constraints
        // Create constraints for tierDescriptionLabel

    
        
        
        // Create constraints for stackView
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        stackView.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20).isActive = true

        // Create constraints for tierTitleLabel
        tierTitleLabel.centerXAnchor.constraint(equalTo: stackView.centerXAnchor).isActive = true

        // Create constraints for tierDescriptionLabel
        tierDescriptionLabel.centerXAnchor.constraint(equalTo: stackView.centerXAnchor).isActive = true

        // Create constraints for pricingLabel
        pricingLabel.centerXAnchor.constraint(equalTo: stackView.centerXAnchor).isActive = true

        // Create constraints for subDescriptionLabel
        subDescriptionLabel.centerXAnchor.constraint(equalTo: stackView.centerXAnchor).isActive = true

        // Create constraints for subscribeButton
        subscribeButton.centerXAnchor.constraint(equalTo: stackView.centerXAnchor).isActive = true

        // Set spacing between UI elements in the stack view
        stackView.setCustomSpacing(0, after: tierTitleLabel)
        stackView.setCustomSpacing(40, after: tierDescriptionLabel)
        stackView.setCustomSpacing(30, after: pricingLabel)
        stackView.setCustomSpacing(20, after: subDescriptionLabel)
        stackView.setCustomSpacing(10, after: subscribeButton)
        
        /*
        NSLayoutConstraint.activate([
            // Constraints for the stack view
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            // Add constraints for each label and the button (adjust constants as needed)
            tierTitleLabel.heightAnchor.constraint(equalToConstant: 150),
            tierDescriptionLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 10), // Adjust the minimum height
            pricingLabel.heightAnchor.constraint(equalToConstant: 20),
            subDescriptionLabel.heightAnchor.constraint(equalToConstant: 20),
            subscribeButton.heightAnchor.constraint(equalToConstant: 40),
        ])
        
        
        
        */
    }
    // MARK: - Set Tier Labels
    func setTierLabels(title: String, description: String, pricing: String, subDescription: String)
    {
        tierTitleLabel.text = title
        tierDescriptionLabel.text = description
        pricingLabel.text = pricing
        subDescriptionLabel.text = subDescription
    }
    // MARK: - Set Tier Stack Background Colour
    func setTierStackBackgroundColour(backgroundColour: UIColor) 
    {
        tierStackBackgroundColour = backgroundColour
        backgroundColor = backgroundColour // Update the background color when it's changed
    }
    // MARK: - Set Button Hidden
    func hideSubscribeButton(_ isHidden: Bool) 
    {
        subscribeButton.isHidden = isHidden
    }
    // MARK: - Set Button Title
    func setSubscribeButtonTitle(_ title: String) 
    {
        subscribeButton.setTitle(title, for: .normal)
    }
    //MARK: - Set Subscribe Button Target
    func setSubscribeButtonTarget(target: Any?, action: Selector, for event: UIControl.Event)
    {
        subscribeButton.addTarget(target, action: action, for: event)
    }
    // MARK: - Set Border Color
    func setBorderColor(borderColor: UIColor)
    {
        layer.borderWidth = 1.5
        layer.borderColor = borderColor.cgColor
    }
    
    
    

}

