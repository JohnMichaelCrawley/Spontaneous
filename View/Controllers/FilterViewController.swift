//
//  FilterViewController.swift
//  Spontaneous
//
//  Created by John Michael Crawley on 19/12/2022.
//
/*
 INFORMATION ON THIS CLASS / FILE:

 
 */
// IMPORT LIST
import Foundation
import UIKit


class FilterViewController: UIViewController
{
    // USER DEFAULTS//
    private let USERDEFAULTS = UserDefaults.standard
    //USER INTERFACE//
    @IBOutlet weak var ratingFilterSliderReference: UISlider!
    @IBOutlet weak var pricingFilterSliderReference: UISlider!
    @IBOutlet weak var searchRadiusFilterSlider: UISlider!
    // Labels
    @IBOutlet weak var ratingValueLabel: UILabel!
    @IBOutlet weak var pricingValueLabel: UILabel!
    @IBOutlet weak var searchRadiusValueLabel: UILabel!
    /*
     View Did Load:
     This func is called when loading a view controller
     hierarchy into memory. Then, check the filters
     values and set them in the sliders.
     */
    override func viewDidLoad()
    {
        super.viewDidLoad()
        checkRatingFilter()
        checkPricingFilter()
        checkSearchRadiusFilter()
    }
    /*
     CHECK FUNCTIONS:
     The following check functions are used to check
     and set values when the view controller lanuches.
     Thus, if the user sets the rating slider to a value
     of 4, these functions will set the lable and the
     slider to that value so when the view controller
     re-opens, it will set the values.
     */
    /*
     Check Rating Filter:
     set the search for the ratings of a business to find
     the maximum star rating is 5.
     The fuction firstly sets the value of the UI Slider,
     then checks if the value of the rating is more than 1,
     if it's more than 1 it will plural the, "miles/km"
     then it will print out "1 mile" or if it's over 1 mile,
     "2 miles" etc.
     */
    // Check Rating Filter
    func checkRatingFilter()
    {
        ratingFilterSliderReference.setValue(USERDEFAULTS.float(forKey: "ratingFilter"), animated: false)
    
        
        if USERDEFAULTS.float(forKey: "ratingFilter") > 1
        {
            ratingValueLabel.text = "\(USERDEFAULTS.float(forKey: "ratingFilter")) stars"
        }
        else
        {
            ratingValueLabel.text = "\(USERDEFAULTS.float(forKey: "ratingFilter")) star"
        }
    }
    // Check Pricing Filter
    func checkPricingFilter()
    {
        let pricing = USERDEFAULTS.float(forKey: "pricingFilter")
        // SET VALUE OF SLIDER
        pricingFilterSliderReference.setValue(USERDEFAULTS.float(forKey: "pricingFilter"), animated: false)
        // Set value on a range
        pricingSwitchCase(pricing: Int(pricing))
        
    }
    // Check Search Radius Filter
    func checkSearchRadiusFilter()
    {
        let radius = USERDEFAULTS.float(forKey: "searchRadiusFilter")
        let radiusInMiles = (radius / 16093.44)
        let formattedValue = String(format: "%.2f", radiusInMiles)
        // SET VALUE OF SLIDER
        searchRadiusFilterSlider.setValue(radiusInMiles, animated: false)
        if radius > 1
        {
            searchRadiusValueLabel.text = "\(formattedValue) miles"
        }
        else
        {
            searchRadiusValueLabel.text = "\(formattedValue) mile"
        }
    }
    /*
     UI SLIDERS:
     the following UI functions gets the values
     of the UI Sliders and adjust the labels of
     the corresponding functions, thus, if the
     user adjusts the pricing filter, it will
     automatically update the pricing label
     */
    // Rating Filter Slider
    @IBAction func ratingFilterSlider(_ sender: UISlider)
    {
        let currentValue = Int(sender.value)
        ratingValueLabel.text = "\(currentValue) star"
        // SET THE USER DEFAULTS
        USERDEFAULTS.set(ratingFilterSliderReference.value, forKey: "ratingFilter")
        if USERDEFAULTS.float(forKey: "ratingFilter") > 1
        {
            ratingValueLabel.text = "\(USERDEFAULTS.float(forKey: "ratingFilter")) stars"
        }
        else if USERDEFAULTS.float(forKey: "ratingFilter") < 2
        {
            ratingValueLabel.text = "\(USERDEFAULTS.float(forKey: "ratingFilter")) star"
        }
        else
        {
             ratingValueLabel.text = "\(currentValue) star"
        }
    }
    
    // Pricing Filter Slider
    @IBAction func pricingFilterSlider(_ sender: UISlider)
    {
        let currentValue = Int(sender.value)
        // Set value on a range
        pricingSwitchCase(pricing: currentValue)
        // SET THE USER DEFAULTS
        USERDEFAULTS.set(pricingFilterSliderReference.value, forKey: "pricingFilter")
    }
    
    // Search Radius Filter Slider
    @IBAction func searchRadiusFilterSlider(_ sender: UISlider)
    {
        /*
        MAX SEARCH RADIUS = 50K METERS (31.06856 MILES)...
        IDEAL RADIUS IS 500M - 1KM
         ------
         TO SET MILES TO METERS, MULTIPLY BY 1609
         ------
         FOR EXAMPLE:
         10 MILES X 1,609.344 = 16093.44 METERS
         */
        let currentValue = Float(sender.value)      // Get value from slider
        let radiusValue = (currentValue * 16093.44) // Store the radius value in meters
        let formattedValue = String(format: "%.2f", currentValue)
        if currentValue > 1
        {
            
            searchRadiusValueLabel.text = "\(formattedValue) miles"
        }
        else
        {
            searchRadiusValueLabel.text = "\(formattedValue) mile"
        }
        // SET THE USER DEFAULTS
        USERDEFAULTS.set(radiusValue, forKey: "searchRadiusFilter")
    }
    /*
     DRY: DON'T REPEAT YOURSSELF
     Switch case to check fo the pricing
     */
    private func pricingSwitchCase(pricing: Int)
    {
        // Set value on a range
        switch pricing
        {
        case 1...2:
            pricingValueLabel.text = "€"
        // 3...4
        case 3:
            pricingValueLabel.text = "€€"
        case 4...5:
            pricingValueLabel.text = "€€€"
        default:
            pricingValueLabel.text = "€"
        }
    }
}
