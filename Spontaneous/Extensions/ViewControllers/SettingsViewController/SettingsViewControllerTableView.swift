/*
 Project:           Spontaneous
 File:              SettingsViewControllerTableView.swift
 Created:           24/08/2023
 Author:            John Michael Crawley
 
 Description:
 This extension handles getting data from the view-model
 and sending it to the table in the view controller
*/
//MARK: - Import List
import UIKit
//MARK: - Settings View Controller Extension
extension SettingsViewController: UITableViewDelegate, UITableViewDataSource
{
    //MARK: - Configure Table View Items
    func configureTableViewItems()
    {
        // Main Settings
        settingsViewModel.models.append(Sections(title: "General", options:
        [
            // Filters
            .staticCell(model:  SettingsOptions(title: "Filters", icon: UIImage(systemName: "line.3.horizontal.decrease.circle.fill"), iconBackgroundColour: customColours.returnDefaultUIColour(), handler: {
                
                // let rootVC = SettingsViewController()
                 let filters = FiltersViewController()
                 filters.hidesBottomBarWhenPushed = true
                // rootVC.navigationItem.leftBarButtonItem = UIBarButtonItem( title: "Dismiss",  style: .plain, target: self, action: #selector(self.backButtonPressed) )
                 self.navigationController!.pushViewController(filters, animated: true)
            })),
            // Locations
            .staticCell(model: SettingsOptions(title: "Locations", icon: UIImage(systemName: "location.circle"), iconBackgroundColour: customColours.returnDefaultUIColour(), handler:{
                // let rootVC = SettingsViewController()
                 let locations = LocationsViewController()
                 locations.hidesBottomBarWhenPushed = true
                // rootVC.navigationItem.leftBarButtonItem = UIBarButtonItem( title: "Dismiss",  style: .plain, target: self, action: #selector(self.backButtonPressed) )
                 self.navigationController!.pushViewController(locations, animated: true)
            })),
            // Languages
            .staticCell(model: SettingsOptions(title: "Languages", icon: UIImage(systemName: "globe"), iconBackgroundColour: customColours.returnDefaultUIColour(), handler: {
                let languages = LanguagesViewController() // Replace with your view controller's class name
                 languages.hidesBottomBarWhenPushed = true
                // rootVC.navigationItem.leftBarButtonItem = UIBarButtonItem( title: "Dismiss",  style: .plain, target: self, action: #selector(self.backButtonPressed) )
                 self.navigationController!.pushViewController(languages, animated: true)
            }) ),
            // Theme
            .switchCell(mode: SettingsSwitchOption(title: "Theme Mode", icon: UIImage(systemName: "moon.circle"), iconBackgroundColour: customColours.returnDefaultUIColour(), handler: {}, isOn:
                                                    UserDefaults.standard.bool(forKey: "themeMode")
                                 )),

            // Credits
            .staticCell(model: SettingsOptions(title: "Credits", icon: UIImage(systemName: "person.crop.circle.fill"), iconBackgroundColour: customColours.returnDefaultUIColour(), handler: {
                // let rootVC = SettingsViewController()
                 let credits = CreditsViewController()
                 credits.hidesBottomBarWhenPushed = true
                // rootVC.navigationItem.leftBarButtonItem = UIBarButtonItem( title: "Dismiss",  style: .plain, target: self, action: #selector(self.backButtonPressed) )
                 self.navigationController!.pushViewController(credits, animated: true)
            }) )
        ]))
        //Subscription & API Usage
        let isSignedIn = UserDefaults.standard.bool(forKey: "isSignedInWithApple")
        let displayName = UserDefaults.standard.string(forKey: "appleUserName") ??
                          UserDefaults.standard.string(forKey: "appleUserEmail") ??
                          "Sign in with Apple"

        settingsViewModel.models.append(Sections(title: "Subscription & API Usage", options: [
            .staticCell(model: SettingsOptions(
                title: displayName,
                icon: UIImage(systemName: "person.crop.circle.badge.checkmark"),
                iconBackgroundColour: customColours.returnDefaultUIColour(),
                handler: {
                    if isSignedIn {
                        self.showLogoutPrompt()
                    } else {
                        self.handleAppleSignIn()
                    }
                })),
            // Subscription
            .staticCell(model:  SettingsOptions(title: "Subscription", icon: UIImage(systemName: "dollarsign.arrow.circlepath"), iconBackgroundColour: customColours.returnDefaultUIColour(), handler:
                {
                    
                   // let rootVC = SettingsViewController()
                    let subscription = SubscriptionViewController()
                    subscription.hidesBottomBarWhenPushed = true
                   // rootVC.navigationItem.leftBarButtonItem = UIBarButtonItem( title: "Dismiss",  style: .plain, target: self, action: #selector(self.backButtonPressed) )
                    self.navigationController!.pushViewController(subscription, animated: true)
                }) ),
            // API Usage
            .staticCell(model:  SettingsOptions(title: "Usage", icon: UIImage(systemName: "chart.xyaxis.line"), iconBackgroundColour: customColours.returnDefaultUIColour(), handler:
                {
                    // let rootVC = SettingsViewController()
                     let usage = UsageViewController()
                     usage.hidesBottomBarWhenPushed = true
                    // rootVC.navigationItem.leftBarButtonItem = UIBarButtonItem( title: "Dismiss",  style: .plain, target: self, action: #selector(self.backButtonPressed) )
                     self.navigationController!.pushViewController(usage, animated: true)
                }) ),
        ]))
        //Feedback & Bugs
        settingsViewModel.models.append(Sections(title: "Feedback & Bug Report", options:
        [
            // Send Feedback
            .staticCell(model: SettingsOptions(title: "Send Feedback", icon: UIImage(systemName: "square.and.pencil.circle"), iconBackgroundColour: customColours.returnDefaultUIColour(), handler: 
                                                {
                //Setup the URL, webview and a navigation controller and
                // present the web view controller
                let URL =  "https://github.com/JohnMichaelCrawley/Spontaneous/discussions/categories/general"
                self.openURL(URL)
            })),
            // Send Bug Report
            .staticCell(model: SettingsOptions(title: "Report A Bug", icon: UIImage(systemName: "ladybug.circle"), iconBackgroundColour: customColours.returnDefaultUIColour(), handler: {
                //Setup the URL, webview and a navigation controller and
                // present the web view controller
                let URL = "https://github.com/JohnMichaelCrawley/Spontaneous/issues"
                self.openURL(URL)
            }))
        ]))
    }
    //MARK: - Title For Header In Section (Title of the table view)
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        return settingsViewModel.titleForHeaderInSection(titleForHeaderInSection: section)
    }
    
    //MARK: -  Number of Sections
    func numberOfSections(in tableView: UITableView) -> Int 
    {
        return settingsViewModel.numberOfSections()
    }
    //MARK: - Table View - Number of Rows In Selection
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return settingsViewModel.numberOfRows(numberOfRowsInSection: section)
    }
    //MARK: - Table View - Cell For Row At
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = settingsViewModel.models[indexPath.section].options[indexPath.row]
        switch model.self
        {
        case .staticCell(model: let model):
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: SettingsTableViewCell.INDENTIFER,
                for: indexPath
            ) as? SettingsTableViewCell else
            {
                return UITableViewCell()
            }
            cell.configure(with: model)
            return cell
        case .switchCell(mode: let model):
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: SwitchTableViewCell.INDENTIFER,
                for: indexPath
            ) as? SwitchTableViewCell else
            {
                return UITableViewCell()
            }
            cell.configure(with: model)
            return cell
        }
    }
    //MARK: - Did Select Row At
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) 
    {
        tableView.deselectRow(at: indexPath, animated: true)
        let type = settingsViewModel.models[indexPath.section].options[indexPath.row]
        
        switch type.self
        {
        case .staticCell(model: let model):
            model.handler()
        case .switchCell(mode: let model):
            model.handler()
        }
    }
}
