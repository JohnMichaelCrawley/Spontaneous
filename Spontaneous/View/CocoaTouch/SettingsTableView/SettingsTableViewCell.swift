/*
 Project:           Spontaneous
 File:              SettingsTableViewCell.swift
 Created:           23/08/2023
 Author:            John Michael Crawley
 
 Description:
 This file creates the main table view cell
 being used for 99% of the table view. This
 is used for table view cells without any
 user interface elements (i.e: UISwitch)
*/
//MARK: - Imports
import UIKit
//MARK: - Settings Table View Cell Class
class SettingsTableViewCell: UITableViewCell
{
    //MARK: - Variables
    static let INDENTIFER = "SettingsTableViewCell"
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
    //MARK: - Init Constructor
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(label)
        contentView.addSubview(iconContainer)
        iconContainer.addSubview(iconImageView)
        contentView.clipsToBounds = true
        accessoryType = .disclosureIndicator
    }
    //MARK: - Init for coder
    required init?(coder: NSCoder)
    {
        fatalError()
    }
    //MARK: - Layout Subviews
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
       }
    //MARK: - Prepare for Reuse
    override func prepareForReuse()
    {
        super.prepareForReuse()
        iconImageView.image = nil
        label.text = nil
        iconContainer.backgroundColor = nil
    }
    //MARK: - Configure
    public func configure(with model: SettingsOptions)
    {
        label.text = model.title
        iconImageView.image = model.icon
        iconContainer.backgroundColor = model.iconBackgroundColour
    }
}
