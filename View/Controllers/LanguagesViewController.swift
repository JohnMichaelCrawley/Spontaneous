//
//  LanguagesViewController.swift
//  Spontaneous
//
//  Created by John Michael Crawley on 19/12/2022.
//

import UIKit

class LanguagesViewController: UIViewController
{
    @IBOutlet var languageTableView: UITableView!
    
    let LANGUAGES = ["English (UK)", "Japanese", "Mandarin", "Cantonese", "Italian"]

    override func viewDidLoad()
    {
        super.viewDidLoad()

        languageTableView.delegate = self
        languageTableView.dataSource = self
        
        
        
        // Do any additional setup after loading the view.
    }
    
}


extension LanguagesViewController: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        print("you tapped me at \(indexPath.row)")
     
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
