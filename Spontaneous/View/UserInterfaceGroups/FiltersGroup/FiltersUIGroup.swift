/*
 Project:           Spontaneous
 File:              FiltersUIGroup.swift
 Created:           30/08/2023
 Author:            John Michael Crawley
 
 Description:
 This file creates reusable code so I don't
 repeat creatin U.I elements on the filters
 view controller
 */
//MARK: - Import List
import UIKit
//MARK: - Filters UI Group
class FiltersUIGroup: UIView
{
    //MARK: - Title Label
    private let titleLabel: UILabel =
    {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false  // Disable autoresizing mask
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    //MARK: - Description Label
    private let descriptionLabel: UILabel = 
    {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0 // Allow multiple lines
        label.textAlignment = .center
        label.sizeToFit()
        return label
    }()
    //MARK: - Value Label
    private let valueLabel: UILabel =
    {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    //MARK: - Slider
    private let slider: UISlider = 
    {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()
    //MARK: - Initializer
    override init(frame: CGRect) 
    {
        super.init(frame: frame)
        setupUI()
    }
    //MARK: - Required Init
    required init?(coder: NSCoder) 
    {
        super.init(coder: coder)
        setupUI()
    }
    //MARK: - Configure UI / Setup UI
    // Configure UI components and constraints
    private func setupUI() 
    {
        backgroundColor = .systemBackground
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(slider)
        addSubview(valueLabel)
        // Update constraints
        NSLayoutConstraint.activate([
            // Title
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            // Description
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16), // This makes sure the label fits inside the view
            // Slider
            slider.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            slider.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            slider.bottomAnchor.constraint(equalTo: valueLabel.topAnchor, constant: -8), // Place the slider above valueLabel
            // Value
            valueLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16), // Align valueLabel to the right
            valueLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16) // Align valueLabel to the bottom
        ])
    }
    //MARK: - Configure the Filters UI Group
    func configure(title: String, description: String, value: String, sliderValue: Float) {
        titleLabel.text = title
        descriptionLabel.text = description
        valueLabel.text = value
        slider.value = sliderValue
    }
    //MARK: - Set Label from Overflowing
    func setLabelFromOverflowing(view: UIView)
    {
        descriptionLabel.preferredMaxLayoutWidth = view.bounds.size.width;
    }
    //MARK: - Return slider vlue
    func returnSliderValue() -> Float 
    {
        return slider.value
    }
    // MARK: - Return Slider
    func returnSlider() -> UISlider 
    {
        return slider
    }
    // MARK: - Configure Slider Min
    func configureSliderMinimum(min: Float)
    {
        slider.minimumValue = min
    }
    // MARK: - Configure Slider Max
    func configureSliderMaximum(max: Float)
    {
        slider.maximumValue = max
    }
    // MARK: - Configure Slider Value
    func configureSliderValue(sliderValue: Float)
    {
        slider.value = sliderValue
    }
    // MARK: - Return Slider Min
    func returneSliderMinimum() -> Float
    {
        return slider.minimumValue
    }
    // MARK: - Return Slider Max
    func returnSliderMaximum()  -> Float
    {
      return slider.maximumValue
    }
    // MARK: - Return Slider Value
    func returneSliderValue()  -> Float
    {
        return slider.value
    }
    // MARK: - Update Filters Label
    func updateFilterLabel(updateValueLabel: String)
    {
        valueLabel.text = updateValueLabel
    }
}
