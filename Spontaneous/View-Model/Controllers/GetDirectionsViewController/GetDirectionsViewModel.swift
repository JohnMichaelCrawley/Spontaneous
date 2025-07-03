//
//  GetDirectionsViewModel.swift
//  Spontaneous
//
//  Created by John Crawley on 02/02/2024.
//
import Foundation
import CoreLocation
import GoogleMaps

// MARK: - NC: for updating
extension Notification.Name
{
    static let didUpdateHeading = Notification.Name("didUpdateHeading")
}

// MARK: - Get Directions View Model class
class GetDirectionsViewModel: NSObject, CLLocationManagerDelegate
{
    // MARK: - Dependencies
    private let service = DirectionsService()
    private let locationManager = CLLocationManager()
    private var hasFetchedDirections = false
    // MARK: - State
    var steps: [DirectionsStep] = []
    var currentStepIndex = 0
    var onStepUpdate: ((DirectionsStep) -> Void)?
    var onRouteReady: ((GMSPath, String, String) -> Void)?
    var onLocationReady: ((CLLocationCoordinate2D) -> Void)?
    var onUserLocationUpdate: ((CLLocationCoordinate2D) -> Void)?
    var userLocation: CLLocationCoordinate2D?
    // MARK: - Init
    override init()
    {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.startUpdatingHeading()
        locationManager.headingFilter = 5
        locationManager.headingOrientation = .portrait
    }
    // MARK: - Request Directions
    /*
     This function is responsible for getting walking directions from the user's current location to a specified destination, using a directions service (likely connected to the Google Maps API).

     It starts by checking whether the user's current location is available. If it’s not, it logs a debug message and stops running.

     If the location is available, it logs the starting coordinates and then calls a method to fetch walking directions between the origin (user's location) and the destination. This request is asynchronous, meaning the app continues running while it waits for a response.

     When the directions come back successfully, the function does several things:

     It logs the estimated time of arrival and total walking distance.

     It stores the steps (instructions) that make up the walking route and resets the step counter.

     It immediately updates the UI or app logic with the first navigation step, if there is one.

     It decodes the route into a path object and sends that to another part of the app, along with the ETA and distance, so the route can be drawn on a map or otherwise displayed.

     If the fetch fails, it logs the error message so developers can see what went wrong during debugging.

     The function uses callbacks (onStepUpdate and onRouteReady) to notify the rest of the app when new route data is available. It also uses [weak self] to prevent memory leaks when accessing self inside the closure.
     */
    func getDirections(to destination: CLLocationCoordinate2D, apiKey: String)
    {
        guard let origin = userLocation else
        {
            #if DEBUG
            print("[DEBUG]  getDirections called but userLocation is nil")
            #endif
            return
        }
        #if DEBUG
        print("[DEBUG]  Getting directions from: \(origin.latitude), \(origin.longitude)")
        #endif
        service.fetchWalkingDirections(from: origin, to: destination, apiKey: apiKey) { [weak self] result in
            switch result
            {
            case .success(let (steps, polyline, eta, distance)):
                DispatchQueue.main.async
                {
                    #if DEBUG
                    print("[DEBUG]  Directions received: ETA = \(eta), Distance = \(distance)")
                    #endif
                    self?.steps = steps
                    self?.currentStepIndex = 0
                    if let first = steps.first
                    {
                        #if DEBUG
                        print("[DEBUG]  First step: \(first.instruction)")
                        #endif
                        self?.onStepUpdate?(first)
                    }

                    if let path = GMSPath(fromEncodedPath: polyline) {
                        self?.onRouteReady?(path, eta, distance)
                    }
                }
            case .failure(let error):
                #if DEBUG
                print("[DEBUG] Error fetching directions: \(error.localizedDescription)")
                #endif
            }
        }
    }

    // MARK: - CLLocationManagerDelegate
    /*
     This function runs every time the user's location updates. It takes the most recent location and logs the coordinates if you're in debug mode. If the user's location hasn’t been set yet, it stores it and triggers a callback to signal that the location is ready. It also updates the location every time and notifies the app through another callback.

     If directions haven’t been fetched yet, it marks them as fetched and triggers the location-ready callback again, likely to start the process of getting directions.

     The function also checks how close the user is to the current navigation step. If they’re within 20 meters of that step’s start point, it moves to the next step, updates the UI with the new instruction, and logs it. If there are no more steps, it logs that the user has reached the final step.
     */
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let loc = locations.last else { return }
        let coord = loc.coordinate
        #if DEBUG
        print("[DEBUG] ViewModel location updated: \(coord.latitude), \(coord.longitude)")
        #endif
        if userLocation == nil
        {
            userLocation = coord
            onLocationReady?(coord)
         }
        else
        {
            userLocation = coord
        }
        onUserLocationUpdate?(coord)
        
        
        if !hasFetchedDirections
        {
            userLocation = coord
            onLocationReady?(coord)
            hasFetchedDirections = true
        }
        // Step advancement logic
        guard currentStepIndex < steps.count else { return }

        let currentStep = steps[currentStepIndex]
        let stepLocation = CLLocation(latitude: currentStep.startLocation.latitude, longitude: currentStep.startLocation.longitude)
        let distanceToStep = loc.distance(from: stepLocation)

        if distanceToStep < 20
        {
            currentStepIndex += 1
            if currentStepIndex < steps.count
            {
                let nextStep = steps[currentStepIndex]
                #if DEBUG
                print("[DEBUG]  Advancing to step \(currentStepIndex): \(nextStep.instruction)")
                #endif
                
                onStepUpdate?(nextStep)
            }
            else
            {
                #if DEBUG
                print("[DEBUG] Reached final step")
                #endif
            }
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading)
    {
        let heading = newHeading.trueHeading > 0 ? newHeading.trueHeading : newHeading.magneticHeading
        NotificationCenter.default.post(name: .didUpdateHeading, object: heading)
    }

    // MARK: - location Manager Did change Authorisation
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager)
    {
        // Optional: Handle permissions
    }
}
