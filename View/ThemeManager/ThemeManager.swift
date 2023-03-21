//
//  ThemeManager.swift
//  Spontaneous
//
//  Created by John Michael Crawley on 20/03/2023.
//
/*
 INFORMATION ON THIS CLASS / FILE:
 This is the theme manager for handling
 the dark / light modes of the application.
 The application will use these functions
 to get and set the theme of the application
 */
import Foundation
import GoogleMaps
class ThemeManager
{
    /* Variables */
    // User Defaults
    private let USERDEFAULTS = UserDefaults.standard
    // Selected Theme
    /*
     NOTE TO SELF:
     The willSet observer is called just before the variable's value is set to a new value. It receives the new value as a parameter, which we have named newString in this case.
     The didSet observer is called just after the variable's value has been set to a new value. It receives the old value as a parameter, which we have named oldString in this case.
     */
    private var selectedTheme: String?
    {
        willSet
        {
            self.selectedTheme = getThemeValue()
        }
        didSet
        {
            NotificationCenter.default.post(name: .mapThemeDidChange, object: nil, userInfo: USERDEFAULTS.dictionary(forKey: "applicationTheme"))
            setApplicationTheme(theme: selectedTheme!)
        }
    }
    // Dark theme variables
    // Dark style JSON for Google Map
    private let styleURL = Bundle.main.url(forResource: "style", withExtension: "json")
    // Access the UI Application connected scenes
    private var window = UIApplication.shared.connectedScenes.compactMap { ($0 as? UIWindowScene)?.keyWindow }.first
    /*
     Function - set Entire Applicaton Theme:
     This function sets the theme for both application and
     theme. This function is used for View Controller's that
     have a map view
     */
    func setEntireApplicatonTheme(theme: String, mapView: GMSMapView)
    {
        switch theme
        {
        case "dark":
           // printToConsoleTheme()
            window?.overrideUserInterfaceStyle = .dark
            setMapThemeToDark(mapView: mapView)
        case "light":
          //  printToConsoleTheme()
            window?.overrideUserInterfaceStyle = .light
            setMapThemeToLight(mapView: mapView)
        default:
          //  printToConsoleTheme()
            window?.overrideUserInterfaceStyle = .light
            setMapThemeToLight(mapView: mapView)
        }
    }
    /*
     Function - set Application Theme:
     This function is used for View Controllers
     that don't have any Map Views,
     */
    func setApplicationTheme(theme: String)
    {
        switch theme
        {
        case "dark":
         //   printToConsoleTheme()
            window?.overrideUserInterfaceStyle = .dark
        case "light":
         //   printToConsoleTheme()
            window?.overrideUserInterfaceStyle = .light
        default:
         //   printToConsoleTheme()
                window?.overrideUserInterfaceStyle = .light
        }
    }
    // Function used to set the GMS Map View to Dark
    func setMapThemeToDark(mapView: GMSMapView)
    {
        mapView.mapStyle = try! GMSMapStyle(contentsOfFileURL: styleURL!)
        #if DEBUG
        print("\n\nDark mode should be enabled on Map View \n\n")
        #endif
    }
    // Function used to set the GMS Map View to Light
    func setMapThemeToLight(mapView: GMSMapView)
    {
        mapView.mapStyle = .none
        #if DEBUG
        print("\n\nLight mode should be enabled on Map View \n\n")
        #endif
    }
    // Debug - check the current theme
    func printToConsoleTheme()
    {
        #if DEBUG
        print("\n\n\n")
        print("*************************************")
        print("The current theme is : \(getThemeValue())")
        print("The current [var] theme value is : \(selectedTheme ?? "")")
        print("*************************************")
        print("\n\n\n")
        #endif
    }
    /*
     Selected Theme String
     SETTER & GETTER.
     Set the theme value using the SETTER
     Get the theme value using the GETTER
     */
    func setThemeValue(value: String)
    {
        selectedTheme = value
    }
    func getThemeValue() -> String
    {
        return selectedTheme ?? ""
    }
}
