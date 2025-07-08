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
//MARK: - Get Directions View Controller
class GetDirectionsViewController: UIViewController, UINavigationControllerDelegate, GMSMapViewDelegate
{
    // Variables
    let place = PlacesManager.shared.returnSinglePlace()
    let customColour = CustomColours()
    let viewModel = GetDirectionsViewModel()
    var mapView: GMSMapView!
    var userMarker: GMSMarker?
    var directionMarker: GMSMarker?
    var currentPolyline: GMSPolyline?
    // MARK: - User Interface elements
    // Instructions label
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
    // ETA label
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
    // MARK: - View Did Load
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.title = "\(place.name) directions"
        configureGoogleMapsMapView()
        configureLabels()
        bindViewModel()
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
            etaLabel.heightAnchor.constraint(equalToConstant: 50)])
    }
    // MARK: - Configure labels
    func configureLabels()
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
            etaLabel.heightAnchor.constraint(equalToConstant: 50)])
    }
    
    // MARK: - Bind View Model
    func bindViewModel()
    {
      
        
        
        
        viewModel.onUserLocationUpdate = { [weak self] coord, heading in
            guard let self = self else { return }

            DispatchQueue.main.async {
                self.viewModel.userLocation = coord

                if self.userMarker == nil
                {
                    let config = UIImage.SymbolConfiguration(pointSize: 120)
                    if let arrow = UIImage(systemName: "location.north.fill", withConfiguration: config)
                    {
                        let rotated = arrow.withTintColor(.white, renderingMode: .alwaysOriginal).rotated(by: -90)
                        self.userMarker = GMSMarker(position: coord)
                        self.userMarker?.icon = rotated
                        self.userMarker?.zIndex = 999
                        self.userMarker?.map = self.mapView
                    }
                }
                else
                {
                    self.userMarker?.position = coord
                }

                self.userMarker?.rotation = heading

  
                // Always follow user with updated bearing
                          let zoom = self.mapView.camera.zoom > 0 ? self.mapView.camera.zoom : 18.0
                          let camera = GMSCameraPosition.camera(
                              withTarget: coord,
                              zoom: zoom,
                              bearing: heading,
                              viewingAngle: 0
                          )

                          CATransaction.begin()
                          CATransaction.setDisableActions(true) // Instant & smooth camera update
                          self.mapView.animate(to: camera)
                          CATransaction.commit()

                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                

                if !self.viewModel.hasFetchedDirections
                {
                    self.viewModel.hasFetchedDirections = true
                    let dest = CLLocationCoordinate2D(latitude: self.place.latitude, longitude: self.place.longitude)
                    self.viewModel.getDirections(to: dest, apiKey: GoogleAPIManager().returnAPIKey())

                    // Center camera to show both user and destination
                    var bounds = GMSCoordinateBounds()
                    bounds = bounds.includingCoordinate(coord)
                    bounds = bounds.includingCoordinate(dest)

                    let update = GMSCameraUpdate.fit(bounds, withPadding: 80)
                    self.mapView.animate(with: update)
                }
                
                
            }
        }

        viewModel.onRouteReady =
        { [weak self] path, eta, distance in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.drawPolyline(path: path)
                self.addDestinationMarker()
                self.etaLabel.text = "ETA: \(eta) • Distance: \(distance)"
            }
        }

        viewModel.onStepUpdate = { [weak self] step in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.instructionLabel.text = step.instruction
            }
        }
        
        
        
        




        
        
        
        

    }
    
    
    
    
    
    //MARK: - Draw Polyline
    func drawPolyline(path: GMSPath)
    {
        currentPolyline?.map = nil

        let polyline = GMSPolyline(path: path)
        polyline.strokeWidth = 9.0
        polyline.strokeColor = customColour.returnSecondaryUIColour()
        polyline.map = mapView
        currentPolyline = polyline

        guard let userCoord = viewModel.userLocation else { return }
        let destinationCoord = CLLocationCoordinate2D(latitude: place.latitude, longitude: place.longitude)
        var bounds = GMSCoordinateBounds(coordinate: userCoord, coordinate: destinationCoord)

        for index in 0..<path.count() {
            bounds = bounds.includingCoordinate(path.coordinate(at: index))
        }

        let update = GMSCameraUpdate.fit(bounds, withPadding: 80)
        mapView.animate(with: update)
    }

    //MARK: - Add Destination Marker
    func addDestinationMarker()
    {
        guard directionMarker == nil else { return }

        let coord = CLLocationCoordinate2D(latitude: place.latitude, longitude: place.longitude)
        let config = UIImage.SymbolConfiguration(pointSize: 120)

        if let original = UIImage(systemName: "flag.checkered", withConfiguration: config)
        {
            let icon = original.withTintColor(.white, renderingMode: .alwaysOriginal)
            directionMarker = GMSMarker(position: coord)
            directionMarker?.icon = icon
            directionMarker?.map = mapView
            directionMarker?.zIndex = 998
        }
    }


    //MARK: - Configure Google Maps Map View
    func configureGoogleMapsMapView()
    {
        let coord = UserCoordinatesManager.shared.getUserCoordinates().map
        {
            CLLocationCoordinate2D(latitude: $0.latitude, longitude: $0.longitude)
        } ?? CLLocationCoordinate2D(latitude: 53.3498, longitude: -6.2603) // Default to Dublin if no coord

        let camera = GMSCameraPosition.camera(withTarget: coord, zoom: 18.0)
        mapView = GMSMapView(frame: .zero, camera: camera)

        // Important: Set frame or constraints
        mapView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mapView)
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])

        // Initialize Google Map and style
        GoogleMapManager.shared.initializeMap(on: mapView)
        GoogleMapManager.shared.setMapStyle()

        mapView.settings.zoomGestures = true
        mapView.settings.scrollGestures = true
        mapView.settings.rotateGestures = true
        mapView.settings.tiltGestures = false
        mapView.delegate = self
    }


    //MARK: - Notification: Handle Heading Update
    @objc func handleHeadingUpdate(_ notification: Notification)
    {
        guard let heading = notification.object as? CLLocationDirection else { return }
        guard let coord = userMarker?.position else { return }

        let zoom = mapView.camera.zoom > 0 ? mapView.camera.zoom : 18.0
        let camera = GMSCameraPosition.camera(
            withTarget: coord,
            zoom: zoom,
            bearing: heading,
            viewingAngle: 0
        )

        mapView.animate(to: camera)
        userMarker?.rotation = heading
    }
    
    
    
    //MARK: - Notification: Handle User Location
    @objc func handleUserLocation(_ notification: Notification)
    {
        guard let coord = notification.object as? CLLocationCoordinate2D else { return }
        let destination = CLLocationCoordinate2D(latitude: place.latitude, longitude: place.longitude)
        viewModel.getDirections(to: destination, apiKey: GoogleAPIManager().returnAPIKey())
    }
    
    
    //MARK: - View Will Appear
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        tabBarController?.tabBar.isHidden = true    // FIXES iOS26 issue where it doesn't hide the bottom tab
        configureTopNavigationBar()
    }
}
