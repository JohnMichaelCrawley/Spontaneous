//
//  LanguagesViewController.swift
//  Spontaneous
//
//  Created by John Michael Crawley on 19/12/2022.
//
/*
 INFORMATION ON THIS CLASS / FILE:
 This file is a file used for the language VC
 and allowing selection of a language and change
 the application's language. Whatever language is selected
 it will add a checkmark.
 */
// IMPORT LIST
import UIKit

class LanguagesViewController: UIViewController
{
    // VARIABLES //
    // USER INTERFACE
    @IBOutlet var languageTableView: UITableView!
    // USER DEFAULTS//
    let USERDEFAULTS = UserDefaults.standard
    // LANGUAGE ARRAY TO STORE THE VALUES OF ALL LANGUAGES SUPPORTED
    let LANGUAGES = ["English", "Japanese", "Mandarin", "Cantonese", "Italian"]
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
        // Table View Delegate / Datasource
        languageTableView.delegate = self
        languageTableView.dataSource = self
        // Add checkmark to selected row
        let indexPath = IndexPath(row: 0, section: 0)
        languageTableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
        languageTableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.checkmark
    }
    
}
/*
 Table View: Delegate:
 Check if the row is selected, if
 the row is selected then add checkmark
 otherwise remove the checkmark on the row
 */
extension LanguagesViewController: UITableViewDelegate
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
 Add the array of languages count to the number of
 rows in the table and for each row, add the language
 data.
 */
extension LanguagesViewController: UITableViewDataSource
{
    // Set the cell amounts to the number of rows in settings array
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return LANGUAGES.count
    }
    // Display the items of each table view cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "languageCell", for: indexPath)
        
        cell.textLabel?.text = LANGUAGES[indexPath.row]
        
        return cell
    }
}
