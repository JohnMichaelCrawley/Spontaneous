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
    private let USERDEFAULTS = UserDefaults.standard
    // LANGUAGE ARRAY TO STORE THE VALUES OF ALL LANGUAGES SUPPORTED
    @IBOutlet weak var languageHeaderLabel: UILabel!
    private let LANGUAGES = ["English".localised(), "Japanese".localised()]
    
    
    
    
    
    
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
        var indexPath = IndexPath(row: 0, section: 0)
        
        
        // Localise
        languageHeaderLabel.text = "Languages".localised()
        
        let UserDefaultsIndexPathRow = UserDefaults.standard.integer(forKey: "languageSelectionIndexPathRow")
        let UserDefaultsIndexPathSelection = UserDefaults.standard.integer(forKey: "languageSelectionIndexPathSection")
        
        indexPath.row = UserDefaultsIndexPathRow
        indexPath.section = UserDefaultsIndexPathSelection
        
        
        
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
    enum Language: String, CaseIterable {
        case english, japanese

        var code: String {
            switch self
            {
            case .english: return "en"
            case .japanese: return "jp"
            }
        }

        
        static var selected: Language
        {
            set {
                UserDefaults.standard.set([newValue.code], forKey: "AppleLanguages")
                UserDefaults.standard.set(newValue.rawValue, forKey: "language")
                UserDefaults.standard.synchronize()
            }
            get {
                return Language(rawValue: UserDefaults.standard.string(forKey: "language") ?? "") ?? .english
            }
        }
        

    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.checkmark
    
        switch indexPath.row
        {
        case 0:
            print("row: 0 = English")
            // This is done so that network calls now have the Accept-Language as "hi" (Using Alamofire) Check if you can remove these
               UserDefaults.standard.set(["en"], forKey: "AppleLanguages")
               UserDefaults.standard.synchronize()

               // Update the language by swaping bundle
               Bundle.setLanguage("en")

               // Done to reintantiate the storyboards instantly
               let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
               UIApplication.shared.keyWindow?.rootViewController = storyboard.instantiateInitialViewController()
        case 1:
            print("row: 1 = Japanese")
            // This is done so that network calls now have the Accept-Language as "hi" (Using Alamofire) Check if you can remove these
               UserDefaults.standard.set(["ja"], forKey: "AppleLanguages")
               UserDefaults.standard.synchronize()

               // Update the language by swaping bundle
               Bundle.setLanguage("ja")

               // Done to reintantiate the storyboards instantly
               let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
               UIApplication.shared.keyWindow?.rootViewController = storyboard.instantiateInitialViewController()
        default:
            print("default = English")
        }
        
        //
        let selectedLanguage = USERDEFAULTS.string(forKey: "language")!
        print("Selected Language: = : \(selectedLanguage)")

        
        
        
        
        
        USERDEFAULTS.set(indexPath.row, forKey: "languageSelectionIndexPathRow")
        USERDEFAULTS.set(indexPath.section, forKey: "languageSelectionIndexPathSection")
        
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
