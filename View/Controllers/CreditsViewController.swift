//
//  CreditsViewController.swift
//  Spontaneous
//
//  Created by John Michael Crawley on 19/12/2022.
//

import UIKit

class CreditsViewController: UIViewController {

    @IBOutlet var teamTableView: UITableView!
    
    let DEVTEAM = ["John Crawley - Developer", "Anu Sahni - Project Supervisor"]
    let LOCTEAM = ["Chise Negishi - Japanese", ""]
    let SECTION = ["Development Team", "Localisation Team"]
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        teamTableView.delegate = self
        teamTableView.dataSource = self
        
        teamTableView = UITableView(frame: .zero, style: .grouped)
       
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}



extension CreditsViewController: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let HEADER = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
        
        let label = UILabel(frame: CGRect(x: 10, y: 5,
                                          width: HEADER.frame.size.width - 15,
                                          height: HEADER.frame.size.height))
        
        
        HEADER.addSubview(label)
        
        if section == 0
        {
            label.text = "Development Team"
        }
        
        if section == 1
        {
            label.text = "Localisation Team"
        }
        
        
        // label.text = "Header \(section)"
        return HEADER
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
    
    
}



extension CreditsViewController: UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 2
    }
    
    
    
    // Set the cell amounts to the number of rows in settings array
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return DEVTEAM.count
    }
    
    
    
    // Display the items of each table view cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "teamCell", for: indexPath)
        
        if indexPath.section == 0
        {
            cell.textLabel?.text = DEVTEAM[indexPath.row]
        }
        
        if indexPath.section == 1
        {
            cell.textLabel?.text = LOCTEAM[indexPath.row]
        }
        
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        
        return cell
    }
    
}

