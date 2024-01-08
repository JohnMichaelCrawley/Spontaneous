//
//  AppDelegate.swift
//  Spontaneous
//
//  Created by John Crawley on 24/08/2023.
//

import UIKit
import GoogleMaps

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate 
{

    //MARK: - Variables
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool 
    {
        // Set up the main interface
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = TabBarNavigation()
        window.makeKeyAndVisible()
        self.window = window

        
        
        // Google API
        GMSServices.provideAPIKey("\(GoogleAPIManager.shared.returnAPIKey())")
        
        
        // Set some default values
        setUserDefaultsRegister()
     
        // Set Navigation Bar Settings
        NavigationBarCustomiser.customiseNavigationBarAppearance()
        
        // Set the initial theme
      //  AppDelegateManager.shared.setTheme(.light)
        let themeValue = UserDefaults.standard.bool(forKey: "themeMode")
        // Check if theme is on or off and set the theme to that
        if themeValue == true{ThemeViewModel().setTheme(.dark)}
        else {ThemeViewModel().setTheme(.light)}
        // Override point for customization after application launch.
        return true
    }

    

    
    
    



}

