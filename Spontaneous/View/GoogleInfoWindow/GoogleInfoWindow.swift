//
//  GoogleInfoWindowView.swift
//  Spontaneous
//
//  Created by John Crawley on 17/10/2023.
//
//MARK: Import List
import UIKit
// MARK: - Google Info Window View
class GoogleInfoWindowView: UIView
{
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
    //MARK: - User Interface
    //MARK: - Business Name (Label)
    private var nameLabel: UILabel =
    {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 23)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    //MARK: - Business Rating (Label)
    private var ratingLabel: UILabel =
    {
        let label = UILabel()
        label.text = "4.0"
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    //MARK: - Business is Open? (Label)
    private var isOpenLabel: UILabel =
    {
        let label = UILabel()
        label.text = "Open"
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    //MARK: - Business Type (Label)
    private var businessTypeLabel: UILabel =
    {
        let label = UILabel()
        label.text = "Cafe, Restaurant"
        label.font = UIFont.boldSystemFont(ofSize: 10)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
      return label
    }()
    //MARK: - Get Directions To Place (Button)
    let getDirectionsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Get directions", for: .normal)
        button.setTitleColor(.systemBackground, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        button.backgroundColor = .systemCyan
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.white.cgColor
     // button.addTarget(GoogleInfoWindowView.self, action: #selector(getDirectionsToRandomlySelectedPlace), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Get Directions To Randomly Selected Place
    /*
    @objc func getDirectionsToRandomlySelectedPlace()
    {
        #if DEBUG
            print("get directions button pressed")
        #endif
    }*/
    //MARK: - INIT CGREACT
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        configureNIB()
    }
    //MARK: - Init NSCODER
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        configureNIB()
    }
    //MARK: - Awake From NIB
    override func awakeFromNib()
    {
        super.awakeFromNib()
        configureNIB()
    }

    //MARK: - Configure NIB
    func configureNIB()
    {
        // Create vertical stack view for labels
        let labelsStackView = UIStackView(arrangedSubviews: [nameLabel, ratingLabel, isOpenLabel, businessTypeLabel])
        labelsStackView.axis = .vertical
        labelsStackView.spacing = 10
        labelsStackView.translatesAutoresizingMaskIntoConstraints = false
        // Enable user interaction for the button and its superviews
        getDirectionsButton.isUserInteractionEnabled = true
        // Add elements to the custom view
        addSubview(labelsStackView)
        self.addSubview(getDirectionsButton)
        // Set up constraints
        NSLayoutConstraint.activate([
            labelsStackView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            labelsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            labelsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            
            getDirectionsButton.topAnchor.constraint(equalTo: labelsStackView.bottomAnchor, constant: 10),
            getDirectionsButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            getDirectionsButton.heightAnchor.constraint(equalToConstant: 40), // Set your custom height
            getDirectionsButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
            
        ])
    }
}
