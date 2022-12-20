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
    @IBOutlet weak var radiusFilterSliderReference: UISlider!
    @IBOutlet weak var pricingFilterSliderReference: UISlider!
    @IBOutlet weak var searchRadiusFilterSlider: UISlider!
    
    // Labels
    @IBOutlet weak var ratingValueLabel: UILabel!
    @IBOutlet weak var pricingValueLabel: UILabel!
    @IBOutlet weak var searchRadiusValueLabel: UILabel!
    
    

    override func viewDidLoad()
    {
        super.viewDidLoad()
        checkRatingFilter()
        checkPricingFilter()
        checkSearchRadiusFilter()
    }
    
    
    
    
    func checkRatingFilter()
    {

        // SET VALUE OF SLIDER
        radiusFilterSliderReference.setValue(USERDEFAULTS.float(forKey: "ratingFilter"), animated: false)
      //  ratingValueLabel.setValue("(\(ratingValueLabel.text!)", forKey: "radiusFilterLabel")
        
    
    }

    
    func checkPricingFilter()
    {

        // SET VALUE OF SLIDER
        pricingFilterSliderReference.setValue(USERDEFAULTS.float(forKey: "pricingFilter"), animated: false)
      //  ratingValueLabel.setValue("(\(ratingValueLabel.text!)", forKey: "radiusFilterLabel")
        
    
    }
    
    func checkSearchRadiusFilter()
    {

        // SET VALUE OF SLIDER
        searchRadiusFilterSlider.setValue(USERDEFAULTS.float(forKey: "searchRadiusFilter"), animated: false)
      //  ratingValueLabel.setValue("(\(ratingValueLabel.text!)", forKey: "radiusFilterLabel")
        
    
    }

    
    
    
    
    
    

    @IBAction func ratingFilterSlider(_ sender: UISlider)
    {
        let currentValue = Int(sender.value)
        print(currentValue)
        ratingValueLabel.text = "\(currentValue) star"
        
        print(ratingValueLabel.text!)
        
        
        // SET THE USER DEFAULTS
        USERDEFAULTS.set(radiusFilterSliderReference.value, forKey: "ratingFilter")
       // USERDEFAULTS.set("(\(ratingValueLabel.text!)", forKey: "ratingFilterLabel")
    }
    
    
    @IBAction func pricingFilterSlider(_ sender: UISlider)
    {
        let currentValue = Int(sender.value)
        print(currentValue)
        pricingValueLabel.text = "\(currentValue) €"
        
        print(pricingValueLabel.text!)
        
        
        // SET THE USER DEFAULTS
        USERDEFAULTS.set(pricingFilterSliderReference.value, forKey: "pricingFilter")
       // USERDEFAULTS.set("(\(ratingValueLabel.text!)", forKey: "ratingFilterLabel")
    }
    
    
    @IBAction func searchRadiusFilterSlider(_ sender: UISlider)
    {
        let currentValue = Int(sender.value)
        print(currentValue)
        searchRadiusValueLabel.text = "\(currentValue) mile"
        
        print(searchRadiusValueLabel.text!)
        
        
        // SET THE USER DEFAULTS
        USERDEFAULTS.set(searchRadiusFilterSlider.value, forKey: "searchRadiusFilter")
       // USERDEFAULTS.set("(\(ratingValueLabel.text!)", forKey: "ratingFilterLabel")
    }
    
    
    
    
    
    
}

