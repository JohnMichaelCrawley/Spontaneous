/*
 Project:           Spontaneous
 File:              SwitchTableViewCell.swift
 Created:           23/08/2023
 Author:            John Michael Crawley
 
 Description:
 This file creates a table view cell with the 
 ability to have a UISwitch interface that can
 be switched on or off for the dark mode.
 The switch will send run code that when on or
 off it will tell the entire application to switch
 between dark or light mode
 */
//MARK: - Import list
import UIKit
//MARK: - Switch Table View Cell Class
class SwitchTableViewCell: UITableViewCell
{
    let themeManager = ThemeViewModel()
    
    
    //MARK: - Variables
    static let INDENTIFER = "SwitchTableViewCell"
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
    // Icon Image View - this U.I element is where the image will be displayed
    private let iconImageView: UIImageView =
    {
        let imageView = UIImageView()
        imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    //Label - This U.I element is used for showing the cell's text (i.e: filters, locations etc)
    private let label: UILabel =
    {
        let label = UILabel()
        label.numberOfLines = 1
        return label
    }()
    // Theme Mode Switch - This U.I element is the UISwitch that changes the app into dark/light mode
    private let themeModeSwitch: UISwitch =
    {
        let themeModeSwitch = UISwitch()
        themeModeSwitch.onTintColor = .systemBackground
        themeModeSwitch.isOn = UserDefaults.standard.bool(forKey: "themeMode")
        return themeModeSwitch
    }()
    //MARK: - Init Constructor
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(label)
        contentView.addSubview(iconContainer)
        iconContainer.addSubview(iconImageView)
        contentView.addSubview(themeModeSwitch)
        contentView.clipsToBounds = true
        uiSwitchState()
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
        let containerSize: CGFloat = contentView.frame.size.height - 2 * padding
        let containerOriginY: CGFloat = (contentView.frame.size.height - containerSize) / 2 // Vertically center the container
        iconContainer.frame = CGRect(x: padding, y: containerOriginY, width: containerSize, height: containerSize)
        let imageSize: CGFloat = containerSize * 1
        let imageOrigin = (containerSize - imageSize) / 2
        iconImageView.frame = CGRect(x: imageOrigin, y: imageOrigin, width: imageSize, height: imageSize)
        // Configure the label
        label.frame = CGRect(x: iconContainer.frame.origin.x + iconContainer.frame.size.width + padding, y: padding, width: contentView.frame.size.width - (iconContainer.frame.origin.x + iconContainer.frame.size.width + padding), height: contentView.frame.size.height - 2 * padding)
        // Configure the theme mode UISwitch
        themeModeSwitch.sizeToFit()
        themeModeSwitch.frame = CGRect(x: contentView.frame.size.width - themeModeSwitch.frame.size.width  - 20, y: (contentView.frame.size.height - themeModeSwitch.frame.size.height)/2, width: themeModeSwitch.frame.size.width, height: themeModeSwitch.frame.size.height)
        themeModeSwitch.addTarget(self, action: #selector(themeModeSwitchValueChanged), for: .valueChanged)
       }
    //MARK: - Prepare for Reuse - This function resets the U.I for using the cell again
    override func prepareForReuse()
    {
        super.prepareForReuse()
        iconImageView.image = nil
        label.text = nil
        iconContainer.backgroundColor = nil
        themeModeSwitch.isOn = false
    }
    //MARK: - Configure - this function configures all the U.I for the cell
    public func configure(with model: SettingsSwitchOption)
    {
        label.text = model.title
        iconImageView.image = model.icon
        iconContainer.backgroundColor = model.iconBackgroundColour
        themeModeSwitch.isOn = model.isOn
    }
    //MARK: - Selector - Theme Mode Switch Value Changed
    @objc func themeModeSwitchValueChanged(sender: UISwitch)
    {
        uiSwitchState()
    }
    //MARK: - UI Switch State - This checks if the UISwitch is on or off
    func uiSwitchState()
    {
        // Dark mode is enabled
        if themeModeSwitch.isOn
        {
            UserDefaults.standard.set(themeModeSwitch.isOn, forKey: "themeMode")
            themeManager.setTheme(.dark)
            themeModeSwitch.onTintColor = .black
            themeModeSwitch.tintColor = .systemGray3
            GoogleMapManager.shared.setMapStyle()
        }
        // Light mode is enabled
        else
        {
            UserDefaults.standard.set(false, forKey: "themeMode")
            themeManager.setTheme(.light)
            themeModeSwitch.tintColor = .white
            themeModeSwitch.tintColor = .systemBackground
            GoogleMapManager.shared.setMapStyle()
        }
    }
}
