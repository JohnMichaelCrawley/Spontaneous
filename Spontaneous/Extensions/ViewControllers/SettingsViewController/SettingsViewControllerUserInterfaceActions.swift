/*
 Project:           Spontaneous
 File:              SettingsViewControllerUserInterfaceActions.swift
 Created:           06/09/2023
 Author:            John Michael Crawley
 
 Description:
 This file handles all the actions on the settings view controller
 outside of the table view. This file currently only has the ability to
 open a Safari link to the GitHub repo' for the project
*/
//MARK: - Import List
import UIKit
// MARK: - Settings View Controller Extension - User Interface Actions
extension SettingsViewController
{
    //MARK: - Open URL (This opens a URL in Safari)
    func openURL(_ URLString: String)
    {
        if let url = URL(string: URLString), UIApplication.shared.canOpenURL(url) 
        {
            if #available(iOS 13.0, *) 
            {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
                #if DEBUG
                print("Opening Safari...")
                #endif
            } 
            else
            {
                UIApplication.shared.openURL(url)
                #if DEBUG
                print("Cannot open URL: \(url)")
                #endif
            }
        }
    }
}
