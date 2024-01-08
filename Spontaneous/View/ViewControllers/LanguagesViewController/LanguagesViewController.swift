/*
 Project:           Spontaneous
 File:              LanguagesViewController.swift
 Created:           26/08/2023
 Author:            John Michael Crawley
 
 Description:
 This file enables the user to select a language
 to set the application in. The language selection
 will be done through a table view.
 */
//MARK: - Import List
import UIKit
//MARK: - Language View Controller
class LanguagesViewController: UIViewController
{
    // MARK: View Model
    let languageViewModel = LanguagesViewModel()
    //MARK: - User Interface
    // Description label
    let languageDescriptonLabel: UILabel =
    {
        let label = UILabel()
        label.text = "Select a language to change the language of the application."
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 15)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    // Table view
    var languagesTableView: UITableView =
    {
        let table = UITableView(frame: .zero, style: .plain)
      //  table.register(LocationsTableViewCell.self, forCellReuseIdentifier: LocationsTableViewCell.INDENTIFER)
        // Register the cell class with the table view
           table.register(UITableViewCell.self, forCellReuseIdentifier: "LanguageCell")
        table.translatesAutoresizingMaskIntoConstraints = false  // Disable translatesAutoresizingMaskIntoConstraints
        return table
    }()
    //MARK: - View Did Load
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Configure the navigation top bar
        self.title = "Languages"
        // language table view
        // Set the data source and delegate to self
        languagesTableView.dataSource = self
        languagesTableView.delegate = self
        // Configure and Add Table view and label to the subview and
        // add constraints
        configureLanguagesTableViewConstraintsAndSubview()
        configureLanguageDescriptionLabelConstraintsAndSubview()
    }
    //MARK: - View Will Appear
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        showNavigationBar(animated: animated)
    }
   //MARK: - View Will Disappear
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
        hideNavigationBar(animated: animated)
    }
    

    
    
    
    
    
    
    
    
    
    
    
    
}
