//
//  LanguagesViewController.swift
//  Spontaneous
//
//  Created by John Michael Crawley on 19/12/2022.
//

import UIKit

class LanguagesViewController: UIViewController
{
    let USERDEFAULTS = UserDefaults.standard
    
    @IBOutlet var languageTableView: UITableView!
    
    let LANGUAGES = ["English", "Japanese", "Mandarin", "Cantonese", "Italian"]

    override func viewDidLoad()
    {
        super.viewDidLoad()

        languageTableView.delegate = self
        languageTableView.dataSource = self
        
        
      
      //  let languageCell = USERDEFAULTS.set(1, forKey: "languageTableRow")
        
        
        let indexPath = IndexPath(row: 0, section: 0)
        languageTableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
        
        languageTableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.checkmark
        
      //  languageTableView.cellForRow(at: IndexPath)?.accessoryType = UITableViewCell.AccessoryType.checkmark
      
        // Do any additional setup after loading the view.
    }
    
}


extension LanguagesViewController: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        //print("you tapped me at \(indexPath.row)")
        
        /*
         Adds checkmark next to cell
         */
        
        tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.checkmark

    
    }
    
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath)
    {
        tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.none
    }
 
}


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
