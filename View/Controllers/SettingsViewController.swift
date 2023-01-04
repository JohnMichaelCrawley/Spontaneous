//
//  SettingsViewController.swift
//  Spontaneous
//
//  Created by John Michael Crawley on 16/12/2022.
//
/*
 INFORMATION ON THIS CLASS / FILE:
 This file is used for the main 2nd
 view controller for displaying the
 different types of settings the user
 and have two buttons, 1 for the feedback
 reporting to my GitHub and the 2nd is
 for the issue / bug reporting.
 */
// IMPORT LIST
import UIKit
import WebKit
class SetttingsViewController: UIViewController
{
    /* VARIABLES */
    // USER INTERFACE
    @IBOutlet weak var settingsTableView: UITableView!
    // VARIABLES
    let SETTINGS = ["Filters", "Locations", "Languages", "Theme", "Credits"]    // Array to display titles of each settings for the menu
    var index = 0                                                               // Store the index position
    var selectedIndexPath: IndexPath? = nil                                     // Store the selected index path
    // WEB KIT
    let WEBKIT = WKWebView()                                                    // Store the web kit object
    /*
     View Did Load:
     This func is called when loading a view controller
     hierarchy into memory. Using View Did Load,
     I set the cell identifier and delegate and data source
     so when the view loads up, it'll display the data
     and table
     */
    override func viewDidLoad()
    {
        super.viewDidLoad()
        settingsTableView.register(SettingsTableViewCell.nib(), forCellReuseIdentifier: "SettingsTableViewCell")
        settingsTableView.delegate = self
        settingsTableView.dataSource = self
    }
    /*
     SEND SHOW FEEDBACK WEB PAGE:
     this button presents a page for my
     GitHub repo' to send ideas or feedback
     towards my application
     */
    @IBAction func showSendFeedbackWebPage(_ sender: Any)
    {
        guard let url = URL(string: "https://github.com/JohnMichaelCrawley/Spontaneous/discussions/categories/general") else
        {
            return
        }
        
     let vc = WebViewViewController(url: url, title: "Send Feedback")
        
    let navVC = UINavigationController(rootViewController: vc)
        present(navVC, animated: true)
    }
    /*
     SEND SHOW BUG REPORT WEB PAGE:
     this button presents a page for my
     GitHub repo' to send bug reports or issues
     with my application
     */
    @IBAction func showSendBugReportkWebPage(_ sender: Any)
    {
        guard let url = URL(string: "https://github.com/JohnMichaelCrawley/Spontaneous/issues") else
        {
            return
        }
        
     let vc = WebViewViewController(url: url, title: "Report Bug")
    let navVC = UINavigationController(rootViewController: vc)
        present(navVC, animated: true)
    }
}

// TABLE DELEGATE
/*
 Used to help display each view controller (VC)
 */
extension SetttingsViewController: UITableViewDelegate
{
    /*
     This function displays each settings in the settings view controller.
     For example if the user selects the first row (filters) then it will pop
     up with the filters view controller as modality
     */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if selectedIndexPath == indexPath
        {
            // It was already selected
            selectedIndexPath = nil
            tableView.deselectRow(at: indexPath, animated: true)
            settingsTableView.deselectRow(at: indexPath, animated: true)
        }
        else
        {
            switch indexPath.row
            {
            // Filter VC
            case 0:
                let vc = storyboard?.instantiateViewController(withIdentifier: "filterVC") as! FilterViewController
                present(vc, animated: true)
                tableView.deselectRow(at: indexPath, animated: true)
            // Locations VC
            case 1:
                let vc = storyboard?.instantiateViewController(withIdentifier: "locationsVC") as! LocationsViewController
                present(vc, animated: true)
                tableView.deselectRow(at: indexPath, animated: true)
            // Language VC
            case 2:
                let vc = storyboard?.instantiateViewController(withIdentifier: "LanguagesVC") as! LanguagesViewController
                present(vc, animated: true)
                tableView.deselectRow(at: indexPath, animated: true)
            // Theme VC
            case 3:
                let vc = storyboard?.instantiateViewController(withIdentifier: "ThemeVC") as! ThemeViewController
                present(vc, animated: true)
                tableView.deselectRow(at: indexPath, animated: true)
            // Credits VC
            case 4:
                let vc = storyboard?.instantiateViewController(withIdentifier: "CreditsVC") as! CreditsViewController
                present(vc, animated: true)
                tableView.deselectRow(at: indexPath, animated: true)
            default: break
            }
        }
    }
}
// TABLE DATA SOURCE
/*
 Used to return the array of SETTINGS
 into each row to be displayed
 */
extension SetttingsViewController: UITableViewDataSource
{
    // Set the cell amounts to the number of rows in settings array
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return SETTINGS.count
    }
    // Display the items of each table view cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingsTableViewCell.IDENIFIER, for: indexPath) as! SettingsTableViewCell
        cell.configure(with: SETTINGS[indexPath.row])
        cell.delegate = self
        return cell
    }
}
// CELL DELEGATE
extension SetttingsViewController: SettingsTableViewCellDelegate
{
    #if DEBUG
    func didTapButton(with title: String)
    {
        print("Delegate protocol extension")
        print("\(title)")
    }
    #endif
}
