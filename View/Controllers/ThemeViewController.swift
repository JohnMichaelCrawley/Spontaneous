//
//  ThemeViewController.swift
//  Spontaneous
//
//  Created by John Michael Crawley on 19/12/2022.
//

import UIKit

class ThemeViewController: UIViewController
{
    @IBOutlet var themeTableView: UITableView!
    
    let THEME = ["Dark Mode", "Light Mode"]

    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        themeTableView.delegate = self
        themeTableView.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    


}


extension ThemeViewController: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        print("you tapped me at \(indexPath.row)")
     
    }
 
}


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
