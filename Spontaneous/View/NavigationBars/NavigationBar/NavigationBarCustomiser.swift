/*
 Project:           Spontaneous
 File:              NavigationBarCustomiser.swift
 Created:           05/09/2023
 Author:            John Michael Crawley
 
 Description:
 This class helps reduce repeating the same code
 in all the child view controllers and sets an
 overall colour for the navigation top bar.
*/
//MARK: - Import List
import UIKit
// MARK: - Navigation Bar Customizer
class NavigationBarCustomiser
{
    // MARK: - Customise Navigation Bar Appearence
    static func customiseNavigationBarAppearance()
    {
        let navigationBarAppearance = UINavigationBar.appearance()
        navigationBarAppearance.tintColor = UIColor.white
        let attributes: [NSAttributedString.Key: Any] = 
        [
            .foregroundColor: UIColor.tertiarySystemGroupedBackground,
            .font: UIFont.boldSystemFont(ofSize: 17)
            
        ]
        UIBarButtonItem.appearance().setTitleTextAttributes(attributes, for: .normal)
    }
}
