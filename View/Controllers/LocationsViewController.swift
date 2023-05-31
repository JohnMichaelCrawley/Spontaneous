//
//  LocationsViewController.swift
//  Spontaneous
//
//  Created by John Michael Crawley on 19/12/2022.
//
/*
 INFORMATION ON THIS CLASS / FILE:
 This file is used on the locations VC
 for switching on / off businesses i.e:
 turning on / off cafes in the search, resulting
 in adding or removing it from the search for
 a business to find
 */
// IMPORT LIST
import UIKit

class LocationsViewController: UIViewController {

    // USER DEFAULTS//
    let USERDEFAULTS = UserDefaults.standard
    /*
     Labels
     */
    @IBOutlet weak var locationsHeaderLabel: UILabel!
    @IBOutlet weak var locationsSubheaderLabel: UITextView!
    @IBOutlet weak var cafeLabel: UILabel!
    @IBOutlet weak var cinemaLabel: UILabel!
    @IBOutlet weak var restaurantsLabel: UILabel!
    @IBOutlet weak var nightLifeLabel: UILabel!
    @IBOutlet weak var breweryLabel: UILabel!
    @IBOutlet weak var foodMarketLabel: UILabel!
    @IBOutlet weak var aquariumLabel: UILabel!
    @IBOutlet weak var amusementParkLabel: UILabel!
    @IBOutlet weak var museumLabel: UILabel!
    @IBOutlet weak var zooLabel: UILabel!
    @IBOutlet weak var artGalleryLabel: UILabel!
    @IBOutlet weak var bakeryLabel: UILabel!
    @IBOutlet weak var bowlingLabel: UILabel!
    @IBOutlet weak var parkLabel: UILabel!
    @IBOutlet weak var spaLabel: UILabel!
    
    /*
     USER INTERFACE SWITCHES
     These user interface references help set or adjust values
     throughout the program on this file
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
    /*
     View Did Load:
     This func is called when loading a view controller
     hierarchy into memory.Then check for the switch values
     in the USER DEFAULTS and adjust the switches based on
     it.
     */
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Localisation
        
        //MARK: - LABELS
        locationsHeaderLabel.text = "Locations".localised()
        locationsSubheaderLabel.text = "Filtering the locations will remove or add locations to your search. If you remove, 'cafe', it won’t appear in the search for something spontaneous to do.".localised()
        cafeLabel.text = "Cafe".localised()
        cinemaLabel.text = "Cinema".localised()
        restaurantsLabel.text = "Restaurants".localised()
        nightLifeLabel.text = "Night Life".localised()
        breweryLabel.text = "Brewery".localised()
        foodMarketLabel.text = "Food Market".localised()
        aquariumLabel.text = "Aquarium".localised()
        amusementParkLabel.text = "Amusement Park".localised()
        museumLabel.text = "Museum".localised()
        zooLabel.text = "Zoo".localised()
        artGalleryLabel.text = "Art Gallery".localised()
        bakeryLabel.text = "Bakery".localised()
        bowlingLabel.text = "Bowling".localised()
        parkLabel.text = "Park".localised()
        spaLabel.text = "Spa".localised()
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        // Check all the switches
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
     Functions to check for user default values
     and set the values on the switch UI elements
     */
    // Check Cafe Switch
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
    // Check Cinema Switch
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
    // Check Restaurant Switch
    func checkRestaurantSwitch()
    {
        if (USERDEFAULTS.bool(forKey: "restaurantSwitch"))
        {
            restaurantsSwitchReference.setOn(true, animated: false)
        }
        else
        {
            restaurantsSwitchReference.setOn(false, animated: false)
        }
    }
    // Check Night Life Switch
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
    // Check Brewery Switch
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
    // Check Food Market Switch
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
    // Check Aquariam Switch
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
    // Check Amusement Park Switch
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
   // Check Museum Switch
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
    // Check Zoo Switch
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
    // Check Art Gallery Switch
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
    // Check Bakery Switch
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
    // Check Bowling Switch
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
    // Check Park Switch
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
    // Check Spa Switch
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
     SWITCH USER INTERFACE ELEMENTS:
     these functions then will set the value
     of the switch based on the value in the
     USER DEFAULTS for each switch.
     */
    // Check Cafe Switch
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
    // Check Cinema Switch
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
    // Check Restaurant Switch
    @IBAction func restaurantsSwitch(_ sender: UISwitch)
    {
        if (sender.isOn)
        {
            USERDEFAULTS.set(true, forKey: "restaurantSwitch")
        }
        else
        {
            USERDEFAULTS.set(false, forKey: "restaurantSwitch")
        }
    }
    // Check Night Life Switch
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
    // Check Brewery Switch
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
    // Check Food Market Switch
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
    // Check Aquarium Switch
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
    // Check Amusement Park Switch
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
    // Check Museum Switch
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
    // Check Zoo Switch
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
    // Check Art Gallery Switch
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
    // Check Bakery Switch
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
    // Check Bowling Switch
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
    // Check Park Switch
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
    // Check Spa Switch
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
