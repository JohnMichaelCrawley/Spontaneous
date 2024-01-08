/*
 Project:           Spontaneous
 File:              SettingsTableViewCell.swift
 Created:           01/09/2023
 Author:            John Michael Crawley
 
 Description:
 This table view cell creates the table view
 cell for the credits screen / storyboard
*/
//MARK: - Imports
import UIKit
//MARK: - Settings Table View Cell Class
class CreditsTableViewCell: UITableViewCell
{
    //MARK: - Variables
    static let INDENTIFER = "CreditsTableViewCell"
    //MARK: - User Interface
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
        contentView.clipsToBounds = true
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
        // Configure the label
        let labelHeight = contentView.frame.size.height - 2 * padding
        let labelWidth = contentView.frame.size.width - 2 * padding
        // Set the frame for the label to be on the left side of the cell
        label.frame = CGRect(x: padding, y: padding, width: labelWidth, height: labelHeight)
       }
    //MARK: - Prepare for Reuse
    override func prepareForReuse()
    {
        super.prepareForReuse()
        label.text = nil
    }
    //MARK: - Configure
    public func configure(with model: CreditsOptions)
    {
        label.text = "\(model.name) - \(model.role)"
    }
}
