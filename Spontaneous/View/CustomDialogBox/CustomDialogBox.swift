/*
 Project:           Spontaneous
 File:              CustomDialogBox.swift
 Created:           27/02/2024
 Author:            John Michael Crawley
 
 Description:
 This class creates a reusable dialog box to
 use to present a dialog box with title, description
 and a button to the user, this enables to use one
 dialog box and present information such as no
 locations found or their subscription has ended.
 */
//MARK: - Import list
import UIKit
//MARK: - Custom Dialog Box
class CustomDialogBox:  UIViewController
{
    //MARK: - Variables
    // Dialog box
    let dialogView: UIView =
    {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 0.5
        view.layer.borderColor = CustomColours().returnDefaultCGColour()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    // Title label
    let titleLabel: UILabel =
    {
        let label = UILabel()
        label.tintColor = .secondarySystemBackground
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    // Description label
    let descriptionLabel: UILabel =
    {
        let label = UILabel()
        label.tintColor = .secondarySystemBackground
        label.font = UIFont.systemFont(ofSize: 13)
        label.textAlignment = .justified
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    // action Button
    let actionButton: UIButton =
    {
        let button = UIButton(type: .system)
        button.setTitleColor(.secondaryLabel, for: .normal)
        button.backgroundColor = .systemBackground
        button.layer.cornerRadius = 5
        button.layer.borderColor = CustomColours().returnDefaultCGColour()
        button.layer.borderWidth = 1
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    //MARK: - View Did Load
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setupViews()
    }
    //MARK: - Setup Views
    /*
     This function sets the view up by adding each user interface
     element to the view and add the correct constraints to each
     item, finally add a target for the button to dismiss the
     dialog box.
     */
    private func setupViews()
    {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        // Add the dialog box to the view
        view.addSubview(dialogView)
        dialogView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        dialogView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        dialogView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        // Add the title label to the view
        dialogView.addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: dialogView.topAnchor, constant: 20).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: dialogView.leadingAnchor, constant: 20).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: dialogView.trailingAnchor, constant: -20).isActive = true
        // Add the description label to the view
        dialogView.addSubview(descriptionLabel)
        descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true // Reduce the constant value
        descriptionLabel.leadingAnchor.constraint(equalTo: dialogView.leadingAnchor, constant: 20).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: dialogView.trailingAnchor, constant: -20).isActive = true
        // Add the button to the view
        dialogView.addSubview(actionButton)
        actionButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 20).isActive = true
        actionButton.leadingAnchor.constraint(equalTo: dialogView.leadingAnchor, constant: 20).isActive = true
        actionButton.trailingAnchor.constraint(equalTo: dialogView.trailingAnchor, constant: -20).isActive = true
        actionButton.bottomAnchor.constraint(equalTo: dialogView.bottomAnchor, constant: -20).isActive = true
        // Add button target
        actionButton.addTarget(self, action: #selector(dismissDialog), for: .touchUpInside)
    }
    //MARK: - Dismiss Dialog
    /*
     Dismiss the dialog box from the screen
     */
    @objc func dismissDialog()
    {
        dismiss(animated: true, completion: nil)
    }
    //MARK: - Show Dialog
    /*
     Set the labels for title, description and title and then animate and present
     this custom dialog box to the user
     */
    func showDialog(title: String, description: String, buttonTitle: String)
    {
        // Set the dialog box labels
        titleLabel.text = title
        descriptionLabel.text = description
        actionButton.setTitle(buttonTitle, for: .normal)
        
        // Set initial scale and opacity for animation
        dialogView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        dialogView.alpha = 0.0
        
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let rootViewController = windowScene.windows.first?.rootViewController else { return }
        view.backgroundColor = .clear
        modalPresentationStyle = .overFullScreen
        // Animate the dialog box in
        rootViewController.present(self, animated: false) 
        {
            // Animate dialog box in
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.6, options: .curveEaseInOut, animations: {
                self.dialogView.transform = .identity
                self.dialogView.alpha = 1.0
            }, completion: nil)
        }
    }
}
