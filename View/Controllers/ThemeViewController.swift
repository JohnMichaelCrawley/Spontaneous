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
    // THEME SELECTION //
    let THEME = ["Dark Mode", "Light Mode"]
    // USER DEFAULTS //
    let USERDEFAULTS = UserDefaults.standard
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
        tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.checkmark
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
