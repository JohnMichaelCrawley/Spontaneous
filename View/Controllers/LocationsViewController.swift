//
//  LocationsViewController.swift
//  Spontaneous
//
//  Created by John Michael Crawley on 19/12/2022.
//

import UIKit

class LocationsViewController: UIViewController {

    // USER DEFAULTS//
    let USERDEFAULTS = UserDefaults.standard
    // USER INTERFACE SWITCHES //
    /*
     These user interface references help set or adjust values
     throughout the program
     */
    @IBOutlet weak var cafeSwitchReference: UISwitch!
    @IBOutlet weak var cinemaSwitchReference: UISwitch!
    @IBOutlet weak var restaurantsSwitchReference: UISwitch!
    @IBOutlet weak var nightLifeSwitchReference: UISwitch!
    @IBOutlet weak var brewerySwitchReference: UISwitch!
    @IBOutlet weak var foodMarketSwitchReference: UISwitch!
    @IBOutlet weak var aquariumSwitchReference: UISwitch!
    @IBOutlet weak var amusementParkSwitchReference: UISwitch!
    @IBOutlet weak var museumSwitchReference: UISwitch!
    @IBOutlet weak var zooSwitchReference: UISwitch!
    @IBOutlet weak var artGallerySwitchReference: UISwitch!
    @IBOutlet weak var bakerySwitchReference: UISwitch!
    @IBOutlet weak var bowlingSwitchReference: UISwitch!
    @IBOutlet weak var parkSwitchReference: UISwitch!
    @IBOutlet weak var spaSwitchReference: UISwitch!

    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        /*
         Check each Switch for on/off
         */
        checkCafeSwitch()
        checkCinemaSwitch()
        checkRestaurantSwitch()
        checkNightLifeSwitch()
        checkBrewerySwitch()
        checkFoodMarketSwitch()
        checkAquariumSwitch()
        checkAmusementParkSwitch()
        checkMuseumSwitch()
        checkZooSwitch()
        checkArtGallerySwitch()
        checkBakerySwitch()
        checkBowlingSwitch()
        checkParkSwitch()
        checkSpaSwitch()
        
    }
    
    /*
     Functions to check for user default
     values and set the values
     */

    
    func checkCafeSwitch()
    {
        if (USERDEFAULTS.bool(forKey: "cafeSwitch"))
        {
            cafeSwitchReference.setOn(true, animated: false)
        }
        else
        {
            cafeSwitchReference.setOn(false, animated: false)
        }
    }
    
    func checkCinemaSwitch()
    {
        if (USERDEFAULTS.bool(forKey: "cinemaSwitch"))
        {
            cinemaSwitchReference.setOn(true, animated: false)
        }
        else
        {
            cinemaSwitchReference.setOn(false, animated: false)
        }
    }
    
    func checkRestaurantSwitch()
    {
        if (USERDEFAULTS.bool(forKey: "restaurantsSwitch"))
        {
            restaurantsSwitchReference.setOn(true, animated: false)
        }
        else
        {
            restaurantsSwitchReference.setOn(false, animated: false)
        }
    }
    
    func checkNightLifeSwitch()
    {
        if (USERDEFAULTS.bool(forKey: "nightLifeSwitch"))
        {
            nightLifeSwitchReference.setOn(true, animated: false)
        }
        else
        {
            nightLifeSwitchReference.setOn(false, animated: false)
        }
    }
    
    
    func checkBrewerySwitch()
    {
        if (USERDEFAULTS.bool(forKey: "brewerySwitch"))
        {
            brewerySwitchReference.setOn(true, animated: false)
        }
        else
        {
            brewerySwitchReference.setOn(false, animated: false)
        }
    }
    

    func checkFoodMarketSwitch()
    {
        if (USERDEFAULTS.bool(forKey: "foodMarketSwitch"))
        {
            foodMarketSwitchReference.setOn(true, animated: false)
        }
        else
        {
            foodMarketSwitchReference.setOn(false, animated: false)
        }
    }
    
    func checkAquariumSwitch()
    {
        if (USERDEFAULTS.bool(forKey: "aquariumSwitch"))
        {
            aquariumSwitchReference.setOn(true, animated: false)
        }
        else
        {
            aquariumSwitchReference.setOn(false, animated: false)
        }
    }
    
    func checkAmusementParkSwitch()
    {
        if (USERDEFAULTS.bool(forKey: "amusementParkSwitch"))
        {
            amusementParkSwitchReference.setOn(true, animated: false)
        }
        else
        {
            amusementParkSwitchReference.setOn(false, animated: false)
        }
    }
    
    func checkMuseumSwitch()
    {
        if (USERDEFAULTS.bool(forKey: "museumSwitch"))
        {
            museumSwitchReference.setOn(true, animated: false)
        }
        else
        {
            museumSwitchReference.setOn(false, animated: false)
        }
    }
    
    func checkZooSwitch()
    {
        if (USERDEFAULTS.bool(forKey: "zooSwitch"))
        {
            zooSwitchReference.setOn(true, animated: false)
        }
        else
        {
            zooSwitchReference.setOn(false, animated: false)
        }
    }
    
    func checkArtGallerySwitch()
    {
        if (USERDEFAULTS.bool(forKey: "artGallerySwitch"))
        {
            artGallerySwitchReference.setOn(true, animated: false)
        }
        else
        {
            artGallerySwitchReference.setOn(false, animated: false)
        }
    }
    func checkBakerySwitch()
    {
        if (USERDEFAULTS.bool(forKey: "bakerySwitch"))
        {
            bakerySwitchReference.setOn(true, animated: false)
        }
        else
        {
            bakerySwitchReference.setOn(false, animated: false)
        }
    }
    func checkBowlingSwitch()
    {
        if (USERDEFAULTS.bool(forKey: "bowlingSwitch"))
        {
            bowlingSwitchReference.setOn(true, animated: false)
        }
        else
        {
            bowlingSwitchReference.setOn(false, animated: false)
        }
    }
    func checkParkSwitch()
    {
        if (USERDEFAULTS.bool(forKey: "parkSwitch"))
        {
            parkSwitchReference.setOn(true, animated: false)
        }
        else
        {
            parkSwitchReference.setOn(false, animated: false)
        }
    }
    func checkSpaSwitch()
    {
        if (USERDEFAULTS.bool(forKey: "spaSwitch"))
        {
            spaSwitchReference.setOn(true, animated: false)
        }
        else
        {
            spaSwitchReference.setOn(false, animated: false)
        }
    }
    

    /*
     SWITCH UI:
     set the switch UI for the switches
     */
    @IBAction func cafeSwitch(_ sender: UISwitch)
    {
        if (sender.isOn)
        {
            USERDEFAULTS.set(true, forKey: "cafeSwitch")
        }
        else
        {
            USERDEFAULTS.set(false, forKey: "cafeSwitch")
        }
    }
    
    @IBAction func cinemaSwitch(_ sender: UISwitch)
    {
        if (sender.isOn)
        {
            USERDEFAULTS.set(true, forKey: "cinemaSwitch")
        }
        else
        {
            USERDEFAULTS.set(false, forKey: "cinemaSwitch")
        }
    }
    
    @IBAction func restaurantsSwitch(_ sender: UISwitch)
    {
        if (sender.isOn)
        {
            USERDEFAULTS.set(true, forKey: "restaurantsSwitch")
        }
        else
        {
            USERDEFAULTS.set(false, forKey: "restaurantsSwitch")
        }
    }
    
    @IBAction func nightLifeSwitch(_ sender: UISwitch)
    {
        if (sender.isOn)
        {
            USERDEFAULTS.set(true, forKey: "nightLifeSwitch")
        }
        else
        {
            USERDEFAULTS.set(false, forKey: "nightLifeSwitch")
        }
    }
    
    @IBAction func brewerySwitch(_ sender: UISwitch)
    {
        if (sender.isOn)
        {
            USERDEFAULTS.set(true, forKey: "brewerySwitch")
        }
        else
        {
            USERDEFAULTS.set(false, forKey: "brewerySwitch")
        }
    }
    
    @IBAction func foodMarketSwitch(_ sender: UISwitch)
    {
        if (sender.isOn)
        {
            USERDEFAULTS.set(true, forKey: "foodMarketSwitch")
        }
        else
        {
            USERDEFAULTS.set(false, forKey: "foodMarketSwitch")
        }
    }
    
    @IBAction func aquariumSwitch(_ sender: UISwitch)
    {
        if (sender.isOn)
        {
            USERDEFAULTS.set(true, forKey: "aquariumSwitch")
        }
        else
        {
            USERDEFAULTS.set(false, forKey: "aquariumSwitch")
        }
    }
    
    @IBAction func amusementParkSwitch(_ sender: UISwitch)
    {
        if (sender.isOn)
        {
            USERDEFAULTS.set(true, forKey: "amusementParkSwitch")
        }
        else
        {
            USERDEFAULTS.set(false, forKey: "amusementParkSwitch")
        }
    }
    
    @IBAction func museumSwitch(_ sender: UISwitch)
    {
        if (sender.isOn)
        {
            USERDEFAULTS.set(true, forKey: "museumSwitch")
        }
        else
        {
            USERDEFAULTS.set(false, forKey: "museumSwitch")
        }
    }
    
    @IBAction func zooSwitch(_ sender: UISwitch)
    {
        if (sender.isOn)
        {
            USERDEFAULTS.set(true, forKey: "zooSwitch")
        }
        else
        {
            USERDEFAULTS.set(false, forKey: "zooSwitch")
        }
    }
    
    @IBAction func artGallerySwitch(_ sender: UISwitch)
    {
        if (sender.isOn)
        {
            USERDEFAULTS.set(true, forKey: "artGallerySwitch")
        }
        else
        {
            USERDEFAULTS.set(false, forKey: "artGallerySwitch")
        }
    }
    
    
    @IBAction func bakerySwitch(_ sender: UISwitch)
    {
        if (sender.isOn)
        {
            USERDEFAULTS.set(true, forKey: "bakerySwitch")
        }
        else
        {
            USERDEFAULTS.set(false, forKey: "bakerySwitch")
        }
    }
    
    @IBAction func bowlingSwitch(_ sender: UISwitch)
    {
        if (sender.isOn)
        {
            USERDEFAULTS.set(true, forKey: "bowlingSwitch")
        }
        else
        {
            USERDEFAULTS.set(false, forKey: "bowlingSwitch")
        }
    }
    
    
    @IBAction func parkSwitch(_ sender: UISwitch)
    {
        if (sender.isOn)
        {
            USERDEFAULTS.set(true, forKey: "parkSwitch")
        }
        else
        {
            USERDEFAULTS.set(false, forKey: "parkSwitch")
        }
    }
    
    
    @IBAction func spaSwitch(_ sender: UISwitch)
    {
        if (sender.isOn)
        {
            USERDEFAULTS.set(true, forKey: "spaSwitch")
        }
        else
        {
            USERDEFAULTS.set(false, forKey: "spaSwitch")
        }
    }
    
    
}
