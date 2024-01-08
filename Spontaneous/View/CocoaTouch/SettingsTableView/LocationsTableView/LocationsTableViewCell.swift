/*
 Project:           Spontaneous
 File:              LocationsStructs.swift
 Created:           31/08/2023
 Author:            John Michael Crawley
 
 Description:
 This UITableViewCell is specific to Locations
 view controller, this helps create the tableview
 cell for the locations swithces
*/
// Import list
import UIKit
//MARK: - Locations Table View Cell class
class LocationsTableViewCell: UITableViewCell
{
    //MARK: - Variables
    private var model: LocationsSwitchOption?
    private let locationsViewModel = LocationsViewModel()
    static let INDENTIFER = "LocationsTableViewCell"
    //MARK: - User Interface
    // Icon Container - this U.I element is the container for icons
    private let iconContainer: UIView =
    {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        return view
    }()
    //Label - This U.I element is used for showing the cell's text (i.e: filters, locations etc)
    private let label: UILabel =
    {
        let label = UILabel()
        label.numberOfLines = 1
        return label
    }()
    // Theme Mode Switch - This U.I element is the UISwitch that changes the app into dark/light mode
    private lazy var locationSwitch: UISwitch = {
        let locationSwitch = UISwitch()
        locationSwitch.addTarget(self, action: #selector(toggleSwitch(_:)), for: .touchUpInside)
        return locationSwitch
    }()
    //MARK: - Init Constructor
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(label)
        contentView.addSubview(locationSwitch)
        contentView.clipsToBounds = true
    }
    //MARK: - Init for coder
    required init?(coder: NSCoder)
    {
        fatalError()
    }
    //MARK: - Layout Subviews - This func sets up the U.I properties in each cell
    override func layoutSubviews()
    {
        super.layoutSubviews()
        // Configure the image and image container
        let padding: CGFloat = 10
        label.frame = CGRect(x: iconContainer.frame.origin.x + iconContainer.frame.size.width + padding, y: padding, width: contentView.frame.size.width - (iconContainer.frame.origin.x + iconContainer.frame.size.width + padding), height: contentView.frame.size.height - 2 * padding)
        // Configure the theme mode UISwitch
        locationSwitch.sizeToFit()
        locationSwitch.frame = CGRect(x: contentView.frame.size.width - locationSwitch.frame.size.width  - 20, y: (contentView.frame.size.height - locationSwitch.frame.size.height)/2, width: locationSwitch.frame.size.width, height: locationSwitch.frame.size.height)
       }
    //MARK: - Prepare for Reuse - This function resets the U.I for using the cell again
    override func prepareForReuse()
    {
        super.prepareForReuse()
        label.text = nil
        locationSwitch.isOn = false
    }
    //MARK: - Configure - this function configures all the U.I for the cell
    public func configureLocations(with model: LocationsSwitchOption)
    {
        label.text = model.title
        locationSwitch.isOn = model.isOn
        self.model = model
    }
    //MARK: - Toggle UI Switch
    @objc private func toggleSwitch(_ sender: UISwitch)
    {
        // Handle when the key is missing
        guard let defaultsKey = model?.defaultsKey else {return}
        UserDefaults.standard.setValue(sender.isOn, forKey: defaultsKey)
    }
    
    
    
    
    
    

}
