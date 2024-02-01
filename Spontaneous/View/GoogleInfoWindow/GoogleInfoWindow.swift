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
    var placePhoto: UIImage? {
           didSet {
               photoImageView.image = placePhoto
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
    //MARK: - Photo (ImageView)
    private var photoImageView: UIImageView = 
    {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
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
        // Create horizontal stack view for Rating and Is Open labels
        let ratingIsOpenStackView = UIStackView(arrangedSubviews: [ratingLabel, isOpenLabel])
        ratingIsOpenStackView.axis = .horizontal
        ratingIsOpenStackView.spacing = 10
        ratingIsOpenStackView.translatesAutoresizingMaskIntoConstraints = false

        // Create vertical stack view for labels and photo
        let labelsStackView = UIStackView(arrangedSubviews: [photoImageView, nameLabel, ratingIsOpenStackView, businessTypeLabel])
        labelsStackView.axis = .vertical
        labelsStackView.spacing = 10
        labelsStackView.translatesAutoresizingMaskIntoConstraints = false

        // Enable user interaction for the button and its superviews
        // Add elements to the custom view
        addSubview(labelsStackView)

        // Set up constraints
        NSLayoutConstraint.activate([
            photoImageView.heightAnchor.constraint(equalToConstant: 100), // Adjust the height as needed
            labelsStackView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            labelsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            labelsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
        ])
    }
}
