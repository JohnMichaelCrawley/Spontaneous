//
//  SettingsTableViewCell.swift
//  Spontaneous
//
//  Created by John Michael Crawley on 19/12/2022.
//

import UIKit

protocol SettingsTableViewCellDelegate: AnyObject
{
    func didTapButton(with title: String)

}


class SettingsTableViewCell: UITableViewCell
{

    weak var delegate:SettingsTableViewCellDelegate?
    
    
    
    static let IDENIFIER = "SettingsTableViewCell"
    
    private var title: String = ""
    
    
    
    static func nib() -> UINib
    {
        return UINib(nibName: "SettingsTableViewCell", bundle: nil)
    }
    
    
    
    @IBOutlet var button: UIButton!
    
    @IBAction func didTapButton()
    {
        delegate?.didTapButton(with: title)
    }
    
    
    func configure (with title: String)
    {
        self.title = title
        button.setTitle(title, for: .normal)
    }
    
    
    
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
        button.setTitleColor( .link, for: .normal)
    }

  
    
    
    
    
}
