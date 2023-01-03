//
//  SettingsTableViewCell.swift
//  Spontaneous
//
//  Created by John Michael Crawley on 19/12/2022.
//
/*
 INFORMATION ON THIS CLASS / FILE:
 This file is used for the custom cell
 for the navigation menu allowing me to
 adjust the label or button in the cell
 and make custom changes when I need to.
 */
// IMPORT LIST
import UIKit
// Protocol for the did tap button fuc with title
protocol SettingsTableViewCellDelegate: AnyObject
{
    func didTapButton(with title: String)

}
class SettingsTableViewCell: UITableViewCell
{
    // VARIABLES //
    weak var delegate:SettingsTableViewCellDelegate?    // Delegate for the custom cell
    static let IDENIFIER = "SettingsTableViewCell"      // Identifier String
    private var title: String = ""                      // Title String
    @IBOutlet var button: UIButton!                     // UI button for going to a new VC
    // Return the nib with nib idenitifer
    static func nib() -> UINib
    {
        return UINib(nibName: "SettingsTableViewCell", bundle: nil)
    }
    // Function to return if a tap was made
    @IBAction func didTapButton()
    {
        delegate?.didTapButton(with: title)
    }
    // Configure funct to set the title of the button
    func configure (with title: String)
    {
        self.title = title
        button.setTitle(title, for: .normal)
    }
    // Awake Nib and set title colour for the link
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
        button.setTitleColor( .link, for: .normal)
    }
}
