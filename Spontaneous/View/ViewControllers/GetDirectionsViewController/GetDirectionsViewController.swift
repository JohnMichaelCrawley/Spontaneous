/*
 Project:           Spontaneous
 File:              GetDirectionsViewController.swift
 Created:           01/02/2024
 Author:            John Michael Crawley
 
 Description:
 This view controller handles the map view
 and the directions to the selected place
 by the application.
 */
//Import List
import UIKit
import GoogleMaps
class GetDirectionsViewController: UIViewController, UINavigationControllerDelegate {

    let place = PlacesManager.shared.returnSinglePlace()
    let customColour = CustomColours()

    // UI elements
    var mapView: GMSMapView!
    var userMarker: GMSMarker?
    var directionMarker: GMSMarker?
    private let instructionLabel: UILabel =
    {
        let label = UILabel()
        label.backgroundColor = .black.withAlphaComponent(0.7)
        label.textColor = .white
        label.textAlignment = .center
        label.layer.cornerRadius = 8
        label.clipsToBounds = true
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Getting directions..."
        return label
    }()
    private let etaLabel: UILabel =
    {
        let label = UILabel()
        label.backgroundColor = .black.withAlphaComponent(0.7)
        label.textColor = .white
        label.textAlignment = .center
        label.layer.cornerRadius = 8
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Calculating ETA..."
        return label
    }()

    private let viewModel = GetDirectionsViewModel()

    var currentPolyline: GMSPolyline?
    var walkedPolyline: GMSPolyline?
    var remainingPolyline: GMSPolyline?

    // MARK: - View Did Load
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.title = "\(place.name) directions"

        configureGoogleMapsDirectionsDisplay()
        setupInstructionsLabels()
        bindViewModel()

        viewModel.onLocationReady = { [weak self] coord in guard let self = self else { return }
            #if DEBUG
            print("[DEBUG] Location ready at: \(coord.latitude), \(coord.longitude)")
            #endif
            let destination = CLLocationCoordinate2D(latitude: self.place.latitude, longitude: self.place.longitude)
            self.viewModel.getDirections(to: destination, apiKey: GoogleAPIManager().returnAPIKey())
        }
        NotificationCenter.default.addObserver(self, selector: #selector(handleHeadingUpdate(_:)), name: .didUpdateHeading, object: nil)
    }

    // MARK: - Setup Instructions Labels
    func setupInstructionsLabels()
    {
        view.addSubview(instructionLabel)
        view.addSubview(etaLabel)
        NSLayoutConstraint.activate([
            instructionLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            instructionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            instructionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            instructionLabel.heightAnchor.constraint(equalToConstant: 50),
            etaLabel.topAnchor.constraint(equalTo: instructionLabel.bottomAnchor, constant: 8),
            etaLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            etaLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            etaLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    // MARK: - Bind View Model
    func bindViewModel()
    {
        viewModel.onStepUpdate = { [weak self] step in
            DispatchQueue.main.async
            {
                print("[DEBUG]  Updating step label: \(step.instruction)")
                self?.instructionLabel.text = "\(step.instruction) (\(step.distance))"
            }
        }

        viewModel.onRouteReady = { [weak self] path, eta, distance in
            guard let self = self else { return }
            DispatchQueue.main.async {
                let encodedPath = path.encodedPath()
                self.drawPolyline(fromEncodedPath: encodedPath)

                let userLocation = self.viewModel.userLocation ?? path.coordinate(at: 0)
                let destination = CLLocationCoordinate2D(latitude: self.place.latitude, longitude: self.place.longitude)
                self.adjustCameraZoomDynamically(userCoordinate: userLocation, destinationCoordinate: destination)

                self.etaLabel.text = "ETA: \(eta) | Distance: \(distance)"
                self.configureDestinationIcon()
            }
        }

        viewModel.onUserLocationUpdate = { [weak self] location in
            guard let self = self else { return }
            DispatchQueue.main.async {
                if self.userMarker == nil
                {
                    self.userMarker = GMSMarker(position: location)
                    let symbolConfig = UIImage.SymbolConfiguration(pointSize: 120)
                  //  guard let icon = UIImage(systemName: "location.north.circle.fill")?.withConfiguration(symbolConfig) else { return }
                 //   self.userMarker?.icon = icon
                    self.userMarker?.map = self.mapView
                } else {
                    self.userMarker?.position = location
                }
            }
        }
    }

    @objc func handleHeadingUpdate(_ notification: Notification)
    {
        guard let heading = notification.object as? CLLocationDirection else { return }
        userMarker?.rotation = heading
    }

    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        configureTopNavigationBar()
    }
}
