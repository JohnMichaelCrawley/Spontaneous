//
//  ThemeViewController.swift
//  Spontaneous
//
//  Created by John Michael Crawley on 19/12/2022.
//
/*
 INFORMATION ON THIS CLASS / FILE:
This class allows the user to select the
 theme of the application and display it in
 a table view and change the theme based on
 the selection
 */
// IMPORT LIST
import UIKit

class ThemeViewController: UIViewController
{
    // VARIABLES /
    // USER INTERFACE //
    @IBOutlet var themeTableView: UITableView!
    @IBOutlet weak var themeHeaderLabel: UILabel!
    
    
    // THEME SELECTION //
    private let THEME = ["Dark Mode".localised(), "Light Mode".localised()]
    // USER DEFAULTS //
    private let USERDEFAULTS = UserDefaults.standard
    // Theme Manager
    private let themeManager = ThemeManager()
    /*
     View Did Load:
     This func is called when loading a view controller
     hierarchy into memory.I add the table view's
     delegate and datasource as self in order for Xcode
     to load and show the table and the data
     */
    override func viewDidLoad()
    {
        super.viewDidLoad()
        themeTableView.delegate = self
        themeTableView.dataSource = self
        // Set the value for the theme
        themeManager.setThemeValue(value: USERDEFAULTS.string(forKey: "applicationTheme") ?? "")
        themeManager.setApplicationTheme(theme: themeManager.getThemeValue())
        
        // Localise
        themeHeaderLabel.text = "Theme".localised()
        
        
        // Set the cell checkmark
        var indexPath = IndexPath(row: 0, section: 0)
        if themeManager.getThemeValue() == "dark"
        {
            indexPath = IndexPath(row: 0, section: 0)
            themeTableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
            themeTableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.checkmark
        }
        else if themeManager.getThemeValue() == "light"
        {
            indexPath = IndexPath(row: 1, section: 0)
            themeTableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
            themeTableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.checkmark
        }
    }
}
/*
 Table View: Delegate:
 Using the delegate for the table view,
 we check whether the cell was selected or deselected
 and add / remove a checkmark on the row. This shows the
 user which selection the theme is in
 */
extension ThemeViewController: UITableViewDelegate
{
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        // Set theme to DARK
        if indexPath.item == 0
        {
            USERDEFAULTS.set("dark", forKey: "applicationTheme")
            themeManager.setThemeValue(value:  USERDEFAULTS.string(forKey: "applicationTheme") ?? "")
            themeManager.setApplicationTheme(theme: themeManager.getThemeValue())
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.checkmark
        }
        // Set theme to LIGHT
        else if indexPath.item == 1
        {
            USERDEFAULTS.set("light", forKey: "applicationTheme")
            themeManager.setThemeValue(value:  USERDEFAULTS.string(forKey: "applicationTheme") ?? "")
            themeManager.setApplicationTheme(theme: themeManager.getThemeValue())
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.checkmark
        }
        else
        {
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.none
        }
        
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath)
    {
        tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.none
    }
}
/*
 Table View: Data Source:
 This adds the data to the rows of
 the table view.
 */
extension ThemeViewController: UITableViewDataSource
{
    // Set the cell amounts to the number of rows in settings array
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return THEME.count
    }
    // Display the items of each table view cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "themeCell", for: indexPath)
        cell.textLabel?.text = THEME[indexPath.row]
        return cell
    }
}

extension Notification.Name
{
    static let mapThemeDidChange = Notification.Name("mapThemeDidChange")
}
