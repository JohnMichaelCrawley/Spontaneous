//
//  FilterViewController.swift
//  Spontaneous
//
//  Created by John Michael Crawley on 19/12/2022.
//

import Foundation
import UIKit


class FilterViewController: UIViewController
{
    // USER DEFAULTS//
    let USERDEFAULTS = UserDefaults.standard
    
    
    //USER INTERFACE//
    @IBOutlet weak var ratingFilterSliderReference: UISlider!
    @IBOutlet weak var pricingFilterSliderReference: UISlider!
    @IBOutlet weak var searchRadiusFilterSlider: UISlider!
    
    // Labels
    @IBOutlet weak var ratingValueLabel: UILabel!
    @IBOutlet weak var pricingValueLabel: UILabel!
    @IBOutlet weak var searchRadiusValueLabel: UILabel!
    
    

    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Check the rating filters from User Defaults
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
    
    func checkPricingFilter()
    {
        let pricing = USERDEFAULTS.float(forKey: "pricingFilter")

        // SET VALUE OF SLIDER
        pricingFilterSliderReference.setValue(USERDEFAULTS.float(forKey: "pricingFilter"), animated: false)
        
        // Set value on a range
        pricingSwitchCase(pricing: Int(pricing))
        
    }
    
    func checkSearchRadiusFilter()
    {
        let radius = USERDEFAULTS.float(forKey: "searchRadiusFilter")

        // SET VALUE OF SLIDER
        searchRadiusFilterSlider.setValue(USERDEFAULTS.float(forKey: "searchRadiusFilter"), animated: false)
        
        if radius > 1
        {
            searchRadiusValueLabel.text = "\(radius) miles"
        }
        else
        {
            searchRadiusValueLabel.text = "\(radius) mile"
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
    
    

    @IBAction func ratingFilterSlider(_ sender: UISlider)
    {
        let currentValue = Int(sender.value)
       // print(currentValue)
        ratingValueLabel.text = "\(currentValue) star"
        
       // print(ratingValueLabel.text!)
        
        
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
            // print(currentValue)
             ratingValueLabel.text = "\(currentValue) star"
        }
        
       // USERDEFAULTS.set("(\(ratingValueLabel.text!)", forKey: "ratingFilterLabel")
    }
    
    
    @IBAction func pricingFilterSlider(_ sender: UISlider)
    {
        let currentValue = Int(sender.value)
        //print(currentValue)
        
   
        
        // Set value on a range
        pricingSwitchCase(pricing: currentValue)
    
        // pricingValueLabel.text = "\(currentValue) €"
        
     //   print(pricingValueLabel.text!)
        
        
        // SET THE USER DEFAULTS
        USERDEFAULTS.set(pricingFilterSliderReference.value, forKey: "pricingFilter")
       // USERDEFAULTS.set("(\(ratingValueLabel.text!)", forKey: "ratingFilterLabel")
    }
    
    
    @IBAction func searchRadiusFilterSlider(_ sender: UISlider)
    {
        
        /*
        MAX SEARCH RADIUS = 50K METERS (31.06856 MILES)...
        IDEAL RADIUS IS 500M - 1KM
         
         
         TO SET MILES TO METERS, MULTIPLY BY 1609
         
         FOR EXAMPLE:
         10 MILES X 1,609.344 = 16093.44 METERS
         
         
         */
        let currentValue = Int(sender.value)
       // print(currentValue)
        
        if currentValue > 1
        {
            searchRadiusValueLabel.text = "\(currentValue) miles"
        }
        else
        {
            searchRadiusValueLabel.text = "\(currentValue) mile"
        }
        
       // print(searchRadiusValueLabel.text!)
        
        
        // SET THE USER DEFAULTS
        USERDEFAULTS.set(searchRadiusFilterSlider.value, forKey: "searchRadiusFilter")
       // USERDEFAULTS.set("(\(ratingValueLabel.text!)", forKey: "ratingFilterLabel")
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

