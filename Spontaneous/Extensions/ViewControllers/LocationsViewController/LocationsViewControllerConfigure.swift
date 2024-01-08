/*
 Project:           Spontaneous
 File:              LocationsViewControllerConfigure.swift
 Created:           06/09/2023
 Author:            John Michael Crawley
 
 Description:
 This file sets up the list of switches for the locatios
 for the locations view controller. This configure code
 also allows the ability to add UserDefaults into the
 handler:{} section and can set the on / off stuats
*/
//MARK: - Import list
import UIKit
//MARK: - Locations View Controller Extension Table View
//extension LocationsViewController
extension LocationsViewModel
{
    //MARK: - Configure Table View Items
    func configureLocationsTableViewItems()
    {
        model.append(LocationsSwitchOption(title: "Cafe", isOn: UserDefaults.standard.bool(forKey: "cafeSwitch"), defaultsKey: "cafeSwitch"))
        model.append(LocationsSwitchOption(title: "Cinema", isOn: UserDefaults.standard.bool(forKey: "cinemaSwitch"), defaultsKey: "cinemaSwitch"))
        model.append(LocationsSwitchOption(title: "Restaurant", isOn: UserDefaults.standard.bool(forKey: "restaurantSwitch"), defaultsKey: "restaurantSwitch"))
        model.append(LocationsSwitchOption(title: "Night Life", isOn:UserDefaults.standard.bool(forKey: "nightLifeSwitch"), defaultsKey: "nightLifeSwitch"))
        model.append(LocationsSwitchOption(title: "Brewery", isOn: UserDefaults.standard.bool(forKey: "brewerySwitch"), defaultsKey: "brewerySwitch"))
        model.append(LocationsSwitchOption(title: "Food Market", isOn: UserDefaults.standard.bool(forKey: "foodMarketSwitch"), defaultsKey: "foodMarketSwitch"))
        model.append(LocationsSwitchOption(title: "Aquarium",  isOn: UserDefaults.standard.bool(forKey: "aquariumSwitch"), defaultsKey: "aquariumSwitch"))
        model.append(LocationsSwitchOption(title: "Amusement Park",  isOn: UserDefaults.standard.bool(forKey: "amusementParkSwitch"), defaultsKey: "amusementParkSwitch"))
        model.append(LocationsSwitchOption(title: "Museum", isOn: UserDefaults.standard.bool(forKey: "museumSwitch"), defaultsKey: "museumSwitch"))
        model.append(LocationsSwitchOption(title: "Zoo",  isOn: UserDefaults.standard.bool(forKey: "zooSwitch"), defaultsKey: "zooSwitch"))
        model.append(LocationsSwitchOption(title: "Art Gallery", isOn: UserDefaults.standard.bool(forKey: "artGallerySwitch"), defaultsKey: "artGallerySwitch"))
        model.append(LocationsSwitchOption(title: "Bakery",  isOn: UserDefaults.standard.bool(forKey: "bakerySwitch"), defaultsKey: "bakerySwitch"))
        model.append(LocationsSwitchOption(title: "Bowling",  isOn: UserDefaults.standard.bool(forKey: "bowlingSwitch"), defaultsKey: "bowlingSwitch"))
        model.append(LocationsSwitchOption(title: "Park",  isOn: UserDefaults.standard.bool(forKey: "parkSwitch"), defaultsKey: "parkSwitch"))
        model.append(LocationsSwitchOption(title: "Spa",  isOn: UserDefaults.standard.bool(forKey: "spaSwitch"), defaultsKey: "spaSwitch"))
    }
}
