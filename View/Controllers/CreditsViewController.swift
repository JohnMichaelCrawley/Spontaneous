//
//  CreditsViewController.swift
//  Spontaneous
//
//  Created by John Michael Crawley on 19/12/2022.
//

/*
 INFORMATION ON THIS CLASS / FILE:
 This file is used for the credits VC.
 It creates two sections, one for development
 team and another for localisation team,
 under each section, displays the corresponding
 data for each team. 
 */

// IMPORT LIST
import UIKit

class CreditsViewController: UIViewController
{
    
    // USER INTERFACE VARIABLE
    @IBOutlet weak var teamTableView: UITableView!
    // ARRAY VARIABLES
    let DEVTEAM = ["John Crawley - Project developer", "Anu Sahni - Project supervisor"]    // DEVELOPMENT TEAM
    let LOCTEAM = ["Chise Negishi - Japanese", ""]                                          // LOCALISATION TEAM

    /*
     View Did Load:
     This func is called when loading a view controller
     hierarchy into memory. I add the table view's
     delegate and datasource as self in order for Xcode
     to load and show the table and the data
     */
    override func viewDidLoad()
    {
        super.viewDidLoad()
        teamTableView.delegate = self
        teamTableView.dataSource = self
    }
}

// TABLE VIEW Delegate
extension CreditsViewController: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath)
    {
    }
}
// TABLE VIEW DATA SOURCE
extension CreditsViewController: UITableViewDataSource
{
    // Create sections in the table view
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        // Create the header and the label for the header
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 50))
        let label = UILabel(frame: CGRect(x: 5, y: 5, width: header.frame.width, height: header.frame.height))
        header.addSubview(label)
        // First section is DEVTEAM so display the title for "Development Team"
        if section == 0
        {
            label.text = "Development Team:"
        }
        // Second section is LOCTEAM so display the title for "Localisation Team"
        if section == 1
        {
            label.text = "Localisation Team:"
        }
        // Return the header
        return header
    }
    // Return the height for the header in the sections
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return 50
    }
    // Return the number of sections in the table view
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 2
    }
    
    // Set the cell amounts to the number of rows in settings array
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 2
    }
    // Display the items of each table view cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "teamCell", for: indexPath)
        
        /*
         Display the contents of the array in the rows under
         the corresponding headers
         */
        if indexPath.section == 0
        {
            cell.textLabel?.text = DEVTEAM[indexPath.row]
        }
        
        if indexPath.section == 1
        {
            cell.textLabel?.text = LOCTEAM[indexPath.row]
        }
        // Return the cell
        return cell
    }
}
