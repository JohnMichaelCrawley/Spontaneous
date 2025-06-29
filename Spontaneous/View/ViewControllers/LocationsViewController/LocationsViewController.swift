/*
 Project:           Spontaneous
 File:              LocationsViewController.swift
 Created:           26/08/2023
 Author:            John Michael Crawley
 
 Description:
 This is the view controller for the locations
 settings which allows the user to turn on / off
 specifics locations. It gets its data from its
 view model and from that it gets its data from
 the model.
 */
//MARK: - Import List
import UIKit
//MARK: - Location View Controller Class
class LocationsViewController: UIViewController
{
    //MARK: - Variables
    var locationsViewModel = LocationsViewModel()
    //MARK: - User Interface
    // Table View - Show the locations
    var locationsTableView: UITableView =
    {
        let table = UITableView(frame: .zero, style: .plain)
        table.register(LocationsTableViewCell.self, forCellReuseIdentifier: LocationsTableViewCell.INDENTIFER)
        return table
    }()
    // Description label
    let locationsDescriptionLabel: UILabel =
    {
        let label = UILabel()
        label.text = "Filtering the locations will remove or add locations to your search. If you remove, “cafe”, it won’t appear in the search for something spontaneous to do."
        label.textAlignment = .justified
        label.font = UIFont.systemFont(ofSize: 15)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()	
    //MARK: - View Did Load
    override func viewDidLoad() 
    {
        super.viewDidLoad()
        // Configure the navigation top bar
        self.title = "Locations"
        //Configure Description Label and Table view
        configureDescriptionLabelConstraintsAndSubView()
        configureLocationsTableViewConstraintsAndSubView()
        // Set delegate and dataSource for tableView
        locationsTableView.delegate = self
        locationsTableView.dataSource = self
        // Configure the table view items
        locationsViewModel.configureLocationsTableViewItems()
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
