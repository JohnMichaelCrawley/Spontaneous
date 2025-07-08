/*
 Project:           Spontaneous
 File:              SettingsViewController.swift
 Created:           23/08/2023
 Author:            John Michael Crawley
 
 Description:
 This View Controller handles all the user interface
 elements on the view. The functionality is held
 in the View-Model Settings. In this class / file,
 the declaration of user interface variables and
 other variables including the view model,
 custom colours and the viewWillAppear
 and viewWillDisappear will remove any top
 navigation bar.
 */
//MARK: - Import list
import UIKit
import AuthenticationServices
// MARK: - Settings View Controller
class SettingsViewController: UIViewController
{
    // MARK: Variables
    let customColours = CustomColours()
    //MARK: - View Model
    var settingsViewModel: SettingsViewModel = SettingsViewModel()
    //MARK: - User Interface
    // Table View - Show The Settings of the APP
    var settingsTableView: UITableView =
    {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(SettingsTableViewCell.self,
                       forCellReuseIdentifier: SettingsTableViewCell.INDENTIFER)
        table.register(SwitchTableViewCell.self, forCellReuseIdentifier: SwitchTableViewCell.INDENTIFER)
        return table
    }()
    // Versions Label - Get the version number and output to a label
    let versionLabel: UILabel =
    {
        let label = UILabel()
        // Get the app's version from the Bundle
        let versionString: AnyObject? = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as AnyObject
        label.text = "Version: \(versionString!)"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 11)
        label.frame = CGRect(x: 50, y: 800, width: 200, height: 50)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    //MARK: - View Did Load
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Configure the table view models
        // Setup the table view
        view.addSubview(settingsTableView)
        settingsTableView.alwaysBounceVertical = false
        // Set up the tableview delegate and source
        settingsTableView.delegate = self
        settingsTableView.dataSource = self
        // Configure Table View Items
        configureTableViewItems()
        configureSettingsTableViewConstraints()
        // Configure the versions label
        view.addSubview(versionLabel)
        configureVersionLabelConstraints()
     
    }
    //MARK: - View Will Appear
    override func viewWillAppear(_ animated: Bool) 
    {
        super.viewWillAppear(animated)
        hideNavigationBar(animated: animated)
    }
    //MARK: - View Will Disappear
    override func viewWillDisappear(_ animated: Bool) 
    {
        super.viewWillDisappear(animated)
        hideNavigationBar(animated: animated)
    }
    
    
    //MARK: - Show Loguout Prompt
    func showLogoutPrompt()
    {
        let alert = UIAlertController(title: "Sign Out",
                                      message: "Are you sure you want to sign out?",
                                      preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Sign Out", style: .destructive, handler: { _ in
            UserDefaults.standard.removeObject(forKey: "appleUserName")
            UserDefaults.standard.removeObject(forKey: "appleUserEmail")
            UserDefaults.standard.set(false, forKey: "isSignedInWithApple")
            self.settingsTableView.reloadData()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        self.present(alert, animated: true)
    }

    
}


//MARK: - extenson Settings View Controller for Apple Sign-In
extension SettingsViewController: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {

    //MARK: - Handle Apple Sign In
    func handleAppleSignIn()
    {
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.fullName, .email]
        let authController = ASAuthorizationController(authorizationRequests: [request])
        authController.delegate = self
        authController.presentationContextProvider = self
        authController.performRequests()
    }
    // MARK: - Presentation Anchor
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor
    {
        return self.view.window!
    }
    //MARK: - Authorisation Controler
    func authorisationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorisation: ASAuthorization) {
      /*  if let appleIDCredential = authorisation.credential as? ASAuthorizationAppleIDCredential
        {
            let userID = appleIDCredential.user
            let identityToken = appleIDCredential.identityToken
            let tokenString = identityToken.flatMap { String(data: $0, encoding: .utf8) }

            //  You can now send tokenString to AWS Cognito to authenticate
            print("Apple ID Token: \(tokenString ?? "No token")")
            print("User ID: \(userID)")

            if let fullName = appleIDCredential.fullName
            {
                print("Name: \(fullName.givenName ?? "") \(fullName.familyName ?? "")")
            }
        }
       */
        if let appleIDCredential = authorisation.credential as? ASAuthorizationAppleIDCredential
        {
            let userID = appleIDCredential.user
            let identityToken = appleIDCredential.identityToken
            let tokenString = identityToken.flatMap { String(data: $0, encoding: .utf8) }

            // Save to UserDefaults for display later
            if let email = appleIDCredential.email {
                UserDefaults.standard.set(email, forKey: "appleUserEmail")
            }

            if let fullName = appleIDCredential.fullName {
                let displayName = "\(fullName.givenName ?? "") \(fullName.familyName ?? "")"
                UserDefaults.standard.set(displayName, forKey: "appleUserName")
            }

            UserDefaults.standard.set(true, forKey: "isSignedInWithApple")

            // Reload the table to update UI
            settingsTableView.reloadData()
        }

    }
    //MARK: - Authorisation Controller
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("Authorisation failed: \(error.localizedDescription)")
    }
}
