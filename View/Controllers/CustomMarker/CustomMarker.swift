//
//  CustomMarker.swift
//  Spontaneous
//
//  Created by John Michael Crawley on 03/01/2023.
//

import UIKit

class CustomMarker: UIView
{

    // U.I Elements
    @IBOutlet weak var businessNameLabel: UILabel!
    @IBOutlet weak var businessReviewsLabel: UILabel!
    @IBOutlet weak var businessOpeningHours: UILabel!
    @IBOutlet weak var businessPhotos: UIImageView!
    @IBOutlet weak var businessDirectionsButton: UIButton!
    
    

    
    
    
    
    func loadNiB() -> CustomMarker
    {
        let marker = CustomMarker.instancefromNib() as! CustomMarker
        return marker
    }
    
    
    
    
    
    class func instancefromNib() -> UIView
    {
        return UINib(nibName: "CustomMarker", bundle: nil).instantiate(withOwner: self, options: nil).first as! UIView
      }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
