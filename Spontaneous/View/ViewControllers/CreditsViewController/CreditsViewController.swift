/*
 Project:           Spontaneous
 File:              CreditsViewController.swift
 Created:           26/08/2023
 Author:            John Michael Crawley
 
 Description:
 This view controller displays the credits to the app
 from those who helped and wanted their name in the credits.
 It uses a tableview and loads its information from the
 view-model which gets its data from the model.
 
 */
// MARK: - Import list
import UIKit
// MARK: - Credits View Controlelr
class CreditsViewController: UIViewController
{
    //MARK: - View Model
    var creditsViewModel: CreditsViewModel = CreditsViewModel()
    //MARK: - User Interface
    // Table View - Show The Settings of the APP
    var creditsTableView: UITableView =
    {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(CreditsTableViewCell.self,
                       forCellReuseIdentifier: CreditsTableViewCell.INDENTIFER)
        return table
    }()
    //MARK: - View Did Load
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Configure the navigation top bar
        self.title = "Credits"
        // Set the view background colour
        view.backgroundColor = .secondarySystemBackground
        // Configure the table view
        view.addSubview(creditsTableView)
        creditsTableView.delegate = self
        creditsTableView.dataSource = self
        configureCreditsTableViewConstraintsAndAddSubview()
        configureTableViewItems()
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
