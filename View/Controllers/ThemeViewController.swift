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

    var selectedTheme: String = ""
    {
           didSet
        {
            //USERDEFAULTS.set(selectedTheme, forKey: "applicationTheme") ?? ""
            USERDEFAULTS.set(selectedTheme, forKey: "applicationTheme")
            NotificationCenter.default.post(name: .mapThemeDidChange, object: nil)
            print("selected theme has changed and NF shot a notification out")
           }
       }

    
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
       
      //  setCheckmark()
     
        selectedTheme = USERDEFAULTS.string(forKey: "applicationTheme") ?? ""
        setApplicationTheme(theme: selectedTheme)
        var indexPath = IndexPath(row: 0, section: 0)
        if selectedTheme == "dark"
        {
            print("DARK MODE IS TRUE")
            indexPath = IndexPath(row: 0, section: 0)
            themeTableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
            themeTableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.checkmark
        }
        else if selectedTheme == "light"
        {
            print("LIGHT MODE IS TRUE")
            indexPath = IndexPath(row: 1, section: 0)
            themeTableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
            themeTableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.checkmark
        }
        
    }
    
    /*
     Set the applications theme
     */
   public func setApplicationTheme(theme: String)
    {
        // Theme Selection //
        let appDelegate = UIApplication.shared.windows.first
        
        switch selectedTheme
        {
        case "dark":
            selectedTheme = USERDEFAULTS.string(forKey: "applicationTheme") ?? ""
            appDelegate?.overrideUserInterfaceStyle = .dark
        case "light":
            selectedTheme = USERDEFAULTS.string(forKey: "applicationTheme") ?? ""
            appDelegate?.overrideUserInterfaceStyle = .light
        default:
            selectedTheme = USERDEFAULTS.string(forKey: "applicationTheme") ?? ""
            appDelegate?.overrideUserInterfaceStyle = .unspecified
        }
    }

    
   /*
    func setCheckmark()
    {
        let currentTheme:String = USERDEFAULTS.string(forKey: "applicationTheme")!
        
        if currentTheme == "dark"
        {
            print("DARK MODE IS TRUE")
            let cell = themeTableView.cellForRow(at: IndexPath(row: 0, section: 0))
            cell?.accessoryType = .checkmark
        }
        else if currentTheme == "light"
        {
            print("LIGHT MODE IS TRUE")
            let cell = themeTableView.cellForRow(at: IndexPath(row: 1, section: 0))
            cell?.accessoryType = .checkmark
        }
    }
    
    */
    
    
    
    
    
    
    
    
    
    
 
    
    
    
    
    
    
    
    
    
    
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
        
        
        if indexPath.item == 0
        {
           // overrideUserInterfaceStyle = .dark
            USERDEFAULTS.set("dark", forKey: "applicationTheme")
            selectedTheme = USERDEFAULTS.string(forKey: "applicationTheme") ?? ""
            setApplicationTheme(theme: "dark")
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.checkmark
            
        }
        else if indexPath.item == 1
        {
           // overrideUserInterfaceStyle = .light
            USERDEFAULTS.set("light", forKey: "applicationTheme")
            selectedTheme = USERDEFAULTS.string(forKey: "applicationTheme") ?? ""
            setApplicationTheme(theme: "light")
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
