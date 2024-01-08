/*
 Project:           Spontaneous
 File:              TabBarNavigation.swift
 Created:           23/08/2023
 Author:            John Michael Crawley
 
 Description:
 This file handles the tab bar navigation
 menu creating and creating the items for
 each item in the navigation menu
 */
// MARK: - Import List
import UIKit
// MARK: - Tab Bar Navigation
class TabBarNavigation: UITabBarController
{
    //MARK: - Variables
    let customColours = CustomColours()
    //MARK: - Declare View Controllers
    let mainViewController = MainViewController()
    let settingsViewConroller = SettingsViewController()
    //MARK: - View Did Load (Setup the TabBar Navigation)
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.setupTabBarNavigation()
        customiseTabBarNavigation()
    }
    //MARK: - Setup Tab Bar Navigation
    private func setupTabBarNavigation()
    {
        let map = self.createTabBarNavigation(with: "Map", and: UIImage(systemName: "map.circle"), viewController: mainViewController)
        let settings = self.createTabBarNavigation(with: "Settings", and: UIImage(systemName: "gear.circle"), viewController: settingsViewConroller)
        self.setViewControllers([map, settings], animated: true)
    }
    //MARK: - Create Tab Bar Navigation
    private func createTabBarNavigation(with title: String, and image: UIImage?, viewController: UIViewController) -> UINavigationController
    {
        // variable declaration
        let navigation = UINavigationController(rootViewController: viewController)
        // Set the image and tile
        navigation.tabBarItem.title = title
        navigation.tabBarItem.image = image
        // Return the navigation
        return navigation
    }
    //MARK: - Customise Tab Bar
    private func customiseTabBarNavigation()
    {
        let tabBar = self.tabBar
        // Change tab bar border values
        tabBar.layer.borderWidth = 0.3
        tabBar.layer.borderColor = customColours.returnDefaultCGColour()
        // Change tab bar text values
        tabBar.tintColor = customColours.returnDefaultUIColour()
        tabBar.unselectedItemTintColor = customColours.returnSecondaryUIColour()
       // tabBar.scrollEdgeAppearance = UITabBarAppearance().stanard
        tabBar.itemPositioning =  UITabBar.ItemPositioning.fill
        
        
        
        // Set the background color of the tab bar
        tabBar.backgroundColor = .systemBackground
        tabBar.isTranslucent = false
    }
}
