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
    
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
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
    
        
    }
    
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
    
    
    
}
