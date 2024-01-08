/*
 Project:           Spontaneous
 File:              UIViewController.swift
 Created:           26/08/2023
 Author:            John Michael Crawley
 
 Description:
 This is an extension file to all ViewControllers
 to reduce code repetition, allowing D.R.Y
 (Don't Repeat Yourself) which is used to create
 two functions.
 'hideNavigationBar' = This is to hide all the navigation
 top bar. This is used in the main map view controller and
 the settings view controller

 'showNavigationBar' = This is to show a navigation
 top bar. This is used in view controllers like Filters,
 Locations, Languages etc. It displays a back button, title of
 the view controller and the custom colour for the applications
*/
//MARK: - Import list
import UIKit

//MARK: - UI View Controller Extensions
extension UIViewController
{
    // MARK: - Hide Navigation Bar Bottom Tab Bar
    func hideNavigationBottomTabBar(animated: Bool)
    {
        self.tabBarController?.navigationController?.setNavigationBarHidden(true, animated: animated)
        self.tabBarController?.hideNavigationBar(animated: animated)
        self.tabBarController?.tabBar.isHidden = true
        //self.tabBarController?.tabBar.isTranslucent = false
    }
    //MARK: - Hide Navigation Bar
    func hideNavigationBar(animated: Bool)
    {
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    //MARK: - Show Navigation Bar
    func showNavigationBar(animated: Bool)
    {
        // Variables
        let customColours = CustomColours()
        // Show navigation bar
        navigationController?.setNavigationBarHidden(false, animated: animated)
        // check if iOS 13.0 or above is true
        if #available(iOS 13.0, *)
        {
            // Configure the appearnce of the navigation bar
            let appearance = UINavigationBarAppearance()
            // Configure the text colours
            appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
            appearance.backgroundColor = customColours.returnDefaultUIColour()
            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.compactAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
        }
        // else, older version of iOS
        else
        {
            UINavigationBar.appearance().tintColor = CustomColours().returnDefaultUIColour()
            UINavigationBar.appearance().barTintColor =  CustomColours().returnDefaultUIColour()
            UINavigationBar.appearance().isTranslucent = false
        }
    }
}
