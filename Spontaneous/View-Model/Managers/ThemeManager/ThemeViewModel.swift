/*
 Project:           Spontaneous
 File:              ThemeViewModel.swift
 Created:           28/09/2023
 Author:            John Michael Crawley
 
 Description:
 This is the theme view-model controller
 for the application. It takes in the data
 from the Theme model and allow this file
 to a middle-man file for handling the
 theme of the application
 */
//MARK: - Import List
import Foundation
import UIKit
//MARK: - Theme View Model
class ThemeViewModel 
{
    // Variables
    let delegateManager = AppDelegateManager()
    static let shared = ThemeViewModel()
    private var themeModel = Theme.light
    // MARK: - Current Theme GET & SET
    var currentTheme: Theme
    {
        get {
            return themeModel
        }
        set {
            themeModel = newValue
        }
    }
    //MARK: - Set Theme
    func setTheme(_ theme: Theme)
    {
        switch theme
        {
        case .light:
            for windowScene in UIApplication.shared.connectedScenes.compactMap({ $0 as? UIWindowScene })
            {
                for window in windowScene.windows
                {
                    window.overrideUserInterfaceStyle = .light
                }
            }
        case .dark:
            for windowScene in UIApplication.shared.connectedScenes.compactMap({ $0 as? UIWindowScene })
            {
                for window in windowScene.windows
                {
                    window.overrideUserInterfaceStyle = .dark
                }
            }
        }
    }
    //MARK: - Return Current Theme
    func returnCurrentTheme() -> String
    {
        let theme = UserDefaults().bool(forKey: "themeMode")
        if theme == true
        {
            return "dark"
        }
        else
        {
            return "light"
        }
    }
    
    
}



