//
//  SettingsViewController.swift
//  Spontaneous
//
//  Created by John Michael Crawley on 16/12/2022.
//

import UIKit
import WebKit



class SetttingsViewController: UIViewController
{
    /* VARIABLES */
    @IBOutlet weak var settingsTableView: UITableView!
    let settings = ["Filters", "Locations", "Languages", "Theme", "Credits"]
    var index = 0
    var selectedIndexPath: IndexPath? = nil
    
    let WEBKIT = WKWebView()
    
    
    //let sendFeedbackButton: UIButton!

    
    
    /*
     View Did Load
     */
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
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
        
     let vc = WebViewViewController(url: url, title: "Feedback")
        
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
        
     let vc = WebViewViewController(url: url, title: "Bug Report")
    let navVC = UINavigationController(rootViewController: vc)
        present(navVC, animated: true)
    }
    
    
    
    
    
    
    
}


extension SetttingsViewController: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        //print("you tapped me at \(indexPath.row)")
        
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
            // Filter
            case 0:
               // print("wow here")
                let vc = storyboard?.instantiateViewController(withIdentifier: "filterVC") as! FilterViewController
                present(vc, animated: true)
                tableView.deselectRow(at: indexPath, animated: true)
            // Locations
            case 1:
              //  print("wow here")
                let vc = storyboard?.instantiateViewController(withIdentifier: "locationsVC") as! LocationsViewController
                present(vc, animated: true)
                tableView.deselectRow(at: indexPath, animated: true)
                
            // Languages
            case 2:
              //  print("wow here")
                let vc = storyboard?.instantiateViewController(withIdentifier: "LanguagesVC") as! LanguagesViewController
                present(vc, animated: true)
                tableView.deselectRow(at: indexPath, animated: true)
            // Theme
            case 3:
               // print("wow here")
                let vc = storyboard?.instantiateViewController(withIdentifier: "ThemeVC") as! ThemeViewController
                present(vc, animated: true)
                tableView.deselectRow(at: indexPath, animated: true)
            // Credits
            case 4:
               // print("wow here")
                let vc = storyboard?.instantiateViewController(withIdentifier: "CreditsVC") as! CreditsViewController
                present(vc, animated: true)
                tableView.deselectRow(at: indexPath, animated: true)
                
                
            default: break
            }
            

            
        }
          
     
    }
    
    
    
    
    

    
    
}









extension SetttingsViewController: UITableViewDataSource
{
    
    
    
    // Set the cell amounts to the number of rows in settings array
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return settings.count
    }
    
    
    
    // Display the items of each table view cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingsTableViewCell.IDENIFIER, for: indexPath) as! SettingsTableViewCell
        
        
        cell.configure(with: settings[indexPath.row])
 
        
        cell.delegate = self
        
    
        
        return cell
    }

    


    
    
    
}



extension SetttingsViewController: SettingsTableViewCellDelegate
{
    func didTapButton(with title: String)
    {
        print("Delegate protocol extension")
        print("\(title)")
    }
}
