/*
 Project:           Spontaneous
 File:              SettingsViewController.swift
 Created:           23/08/2023
 Author:            John Michael Crawley
 
 Description:
 This View Controller handles all the user interface
 elements on the view. The functionality is held
 in the View-Model Settings. In this class / file,
 the declaration of user interface variables and
 other variables including the view model,
 custom colours and the viewWillAppear
 and viewWillDisappear will remove any top
 navigation bar.
 */
//MARK: - Import list
import UIKit
// MARK: - Settings View Controller
class SettingsViewController: UIViewController
{
    // MARK: Variables
    let customColours = CustomColours()
    //MARK: - View Model
    var settingsViewModel: SettingsViewModel = SettingsViewModel()
    //MARK: - User Interface
    // Table View - Show The Settings of the APP
    var settingsTableView: UITableView =
    {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(SettingsTableViewCell.self,
                       forCellReuseIdentifier: SettingsTableViewCell.INDENTIFER)
        table.register(SwitchTableViewCell.self, forCellReuseIdentifier: SwitchTableViewCell.INDENTIFER)
        return table
    }()
    // Versions Label - Get the version number and output to a label
    let versionLabel: UILabel =
    {
        let label = UILabel()
        // Get the app's version from the Bundle
        let versionString: AnyObject? = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as AnyObject
        label.text = "Version: \(versionString!)"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 11)
        label.frame = CGRect(x: 50, y: 800, width: 200, height: 50)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    //MARK: - View Did Load
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Configure the table view models
        // Setup the table view
        view.addSubview(settingsTableView)
        settingsTableView.alwaysBounceVertical = false
        // Set up the tableview delegate and source
        settingsTableView.delegate = self
        settingsTableView.dataSource = self
        // Configure Table View Items
        configureTableViewItems()
        configureSettingsTableViewConstraints()
        // Configure the versions label
        view.addSubview(versionLabel)
        configureVersionLabelConstraints()
    }
    //MARK: - View Will Appear
    override func viewWillAppear(_ animated: Bool) 
    {
        super.viewWillAppear(animated)
        hideNavigationBar(animated: animated)
    }
    //MARK: - View Will Disappear
    override func viewWillDisappear(_ animated: Bool) 
    {
        super.viewWillDisappear(animated)
        hideNavigationBar(animated: animated)
    }
}
