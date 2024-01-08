//
//  GoogleInfoWindowView.swift
//  Spontaneous
//
//  Created by John Crawley on 17/10/2023.
//

import UIKit

class GoogleInfoWindowView: UIView
{
    //MARK: - User Interface
    //MARK: - Business Name (Label)
    private var nameLabel: UILabel =
    {
      let label = UILabel()
      label.text = "Business Name"
      label.font = UIFont.boldSystemFont(ofSize: 26)
      label.textColor =  .red
      label.translatesAutoresizingMaskIntoConstraints = false
      return label
    }()
    //MARK: - Business Rating (Label)
    private var ratingLabel: UILabel =
    {
      let label = UILabel()
      label.text = "4.0"
      label.font = UIFont.boldSystemFont(ofSize: 26)
      label.textColor =  .red
      label.translatesAutoresizingMaskIntoConstraints = false
      return label
    }()
    //MARK: - Business is Open? (Label)
    private var isOpenLabel: UILabel =
    {
      let label = UILabel()
      label.text = "Open"
      label.font = UIFont.boldSystemFont(ofSize: 26)
      label.textColor =  .red
      label.translatesAutoresizingMaskIntoConstraints = false
      return label
    }()
    //MARK: - Business Type (Label)
    private var businessTypeLabel: UILabel =
    {
      let label = UILabel()
        label.text = "Cafe, Restaurant"
      label.font = UIFont.boldSystemFont(ofSize: 26)
      label.textColor =  .red
      label.translatesAutoresizingMaskIntoConstraints = false
      return label
    }()
    //MARK: - Get Directions To Place (Button)
    let getDirectionsButton: UIButton = {
      let button = UIButton()
      button.setTitle("Get directions", for: .normal)
      button.setTitleColor(.white, for: .normal)
      button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 10)
      button.backgroundColor = .clear
      button.layer.cornerRadius = 10
      button.layer.borderWidth = 2
      button.layer.borderColor = UIColor.white.cgColor
        button.addTarget(GoogleInfoWindowView.self, action: #selector(getDirectionsToRandomlySelectedPlace), for: .touchUpInside)
      button.translatesAutoresizingMaskIntoConstraints = false
      return button
    }()
    //MARK: - Variables
    
    var placeName: String? 
    {
        didSet 
        {
            nameLabel.text = placeName
        }
    }

    var placeRating: String? 
    {
        didSet 
        {
            ratingLabel.text = placeRating
        }
    }

    var placeIsOpen: String? 
    {
        didSet 
        {
            isOpenLabel.text = placeIsOpen
        }
    }

    var placeType: String? 
    {
        didSet 
        {
            businessTypeLabel.text = placeType
        }
    }
    
    // MARK: - Get Directions To Randomly Selected Place
    @objc func getDirectionsToRandomlySelectedPlace()
    {
        #if DEBUG
            print("get directions button pressed")
        #endif
    }
    
    override init(frame: CGRect) 
    {
        super.init(frame: frame)
        
        configureNIB()
      
    }

    required init?(coder aDecoder: NSCoder) 
    {
        super.init(coder: aDecoder)
        configureNIB()
    }
    
    

    
    func configureNIB()
    {
        // Create vertical stack view for labels
              let labelsStackView = UIStackView(arrangedSubviews: [nameLabel, ratingLabel, isOpenLabel, businessTypeLabel])
              labelsStackView.axis = .vertical
              labelsStackView.spacing = 10
              labelsStackView.translatesAutoresizingMaskIntoConstraints = false

              // Add elements to the custom view
              addSubview(labelsStackView)
              addSubview(getDirectionsButton)

              // Set up constraints
              NSLayoutConstraint.activate([
                  labelsStackView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
                  labelsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
                  labelsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),

                  getDirectionsButton.topAnchor.constraint(equalTo: labelsStackView.bottomAnchor, constant: 20),
                  getDirectionsButton.centerXAnchor.constraint(equalTo: centerXAnchor),
                  getDirectionsButton.widthAnchor.constraint(equalToConstant: 150),
              ])
    }
    
    

    
    
    
    
    
}
