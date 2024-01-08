/*
 Project:           Spontaneous
 File:              UsageViewController.swift
 Created:           26/08/2023
 Author:            John Michael Crawley
 
 Description:
 This view controller displays how much usage
 the end-user has used Google API and to change
 their pricing plans if they want to continue.
 */
//MARK: - Import List
import UIKit
//MARK: - Usage View Controller
class UsageViewController: UIViewController 
{
    //MARK: - User Interface
    var circularView = CircularProgressBarView()
    var circularViewDuration: TimeInterval = 2
    let containerView = UIView()
    let circularViewSize: CGFloat = 0 // Adjust the size as needed
    let containerViewWidth: CGFloat = 400
    let containerViewHeight: CGFloat = 450
    // Usage Title label
    let UsageLabel: UILabel =
    {
        let label = UILabel()
        label.text = "You've used 75% of your monthly usage, if you need more, upgrade your subscription plan."
        label.textAlignment = .justified
        label.font = UIFont.systemFont(ofSize: 15)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    //MARK: - View Did Load
    override func viewDidLoad() 
    {
        super.viewDidLoad()
        // Configure the navigation top bar
        self.title = "Usage"
        // Set the view background colour
        view.backgroundColor = .secondarySystemBackground
        // Call the method to set up CircularProgressBarView
        configureCircularProgressBarView()
    }
    //MARK: - View Will Appear
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        showNavigationBar(animated: animated)
    }
   //MARK: - View Will Disappear
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
        hideNavigationBar(animated: animated)
    }
}
