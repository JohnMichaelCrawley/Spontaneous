/*
 Project:           Spontaneous
 File:              FiltersViewController.swift
 Created:           24/08/2023
 Author:            John Michael Crawley
 
 Description:
 This file is the class for the filters view
 controller. This class lays out the user
 interface on the view but does not do any business
 logic or processes other than displaying the
 user interface on the view.
 */
//MARK: - Import list
import UIKit
//MARK: - Filters View Controller Class
class FiltersViewController: UIViewController
{
    //MARK: - User Interface
    // Custom computed property for filtersStackView
    var filtersStackView: UIStackView =
    {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .equalCentering
        stackView.spacing = 20
        return stackView
    }()
    // MARK: - Vertical Spacing CG Float
    // Class property to define the vertical spacing between instances
    static let verticalSpacing: CGFloat = 200
    // MARK: - Create Filters UI Group
    // Create rating group
    let rating = FiltersUIGroup()
    // Create pricing group
    let pricing = FiltersUIGroup()
    // Create search radius group
    let searchRadius = FiltersUIGroup()
    // View Model for filters
    var filtersViewModel = FiltersViewModel()
    //MARK: - View Did Load
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Configure the navigation top bar
        self.title = "Filters"
        // Set the view background colour
        view.backgroundColor = .secondarySystemBackground
        // Configure Filter Group Details
        configureFiltersGroupDetails()
        // Add the stack view to the view hierarchy
        view.addSubview(filtersStackView)
        configureFilterStackViewConstraints()
        configureSubStackRadius()
        // Configure the sliders values
        configureSliderValues()
        // Set from User defaults
        setSliderValuesFromUserDefaults()
        // Update each slider labels
        updateSliderLabels()
        // Add targets for each slider
        rating.returnSlider().addTarget(self, action: #selector(ratingSliderValueChanged(_:)), for: .valueChanged)
        pricing.returnSlider().addTarget(self, action: #selector(pricingSliderValueChanged(_:)), for: .valueChanged)
        searchRadius.returnSlider().addTarget(self, action: #selector(searchRadiusSliderValueChanged(_:)), for: .valueChanged)
    }
    //MARK: - View Will Appear
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
         showNavigationBar(animated: animated)
       // hideNavigationBottomTabBar(animated: animated)
    }
    //MARK: - View Will Disappear
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
       // hideNavigationBar(animated: true)
    }
    
    
    
    
    
    
}
