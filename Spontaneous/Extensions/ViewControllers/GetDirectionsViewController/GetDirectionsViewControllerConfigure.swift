/*
 Project:           Spontaneous
 File:              GetDirectionsViewControllerConfigure.swift
 Created:           01/02/2024
 Author:            John Michael Crawley
 
 Description:
 This file configures elements on the get directions view controller
 both configuring the labels and Google Maps
 
 There is no XCFramework found at '/Users/johncrawley/Desktop/Old/GoogleAPI/GooglePlaces/GooglePlaces-8.2.1/Frameworks/GooglePlaces.xcframework'.

 */
//MARK: - Import list
import UIKit
import GoogleMaps
//MARK: - Get Directions View Controller Extension - Configure
extension GetDirectionsViewController
{
    //MARK: - Fetch Directions
    /*
     Set the directions from the user's original location point to the selected
     place found in the collection array and show a polyline route on Google Maps
     to the destination point using Google API
     */
    func fetchDirections()
    {
        // Handle when user coordinates are unavailable
        guard let userCoordinates = UserCoordinatesManager.shared.getUserCoordinates() else { return }
        let origin = "\(userCoordinates.latitude),\(userCoordinates.longitude)"
        let destination = "\(place.latitude),\(place.longitude)"
        let urlString = "https://maps.googleapis.com/maps/api/directions/json?origin=\(origin)&destination=\(destination)&mode=walking&key=\(GoogleAPIManager().returnAPIKey())"
        if let url = URL(string: urlString) 
        {
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let data = data 
                {
                    do 
                    {
                        if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                           let routes = json["routes"] as? [[String: Any]],
                           let route = routes.first,
                           let polyline = route["overview_polyline"] as? [String: Any],
                           let points = polyline["points"] as? String 
                        {
                            DispatchQueue.main.async
                            {
                                self.drawPolyline(fromEncodedPath: points)
                                // Adjust camera zoom after fetching directions
                            //    self.adjustCameraZoomDynamically(userCoordinate: CLLocationCoordinate2D(latitude: userCoordinates.latitude, longitude: userCoordinates.longitude), destinationCoordinate: CLLocationCoordinate2D(latitude: self.place.latitude, longitude: self.place.longitude))
                            }
                        }
                    } 
                    catch
                    {
                        #if DEBUG
                        print("Error parsing JSON: \(error)")
                        #endif
                    }
                } 
                else if let error = error
                {
                    #if DEBUG
                    print("Error fetching directions: \(error)")
                    #endif
                }
            }
            task.resume()
        }
    }
    //MARK: - Draw Polyline
    /*
     Create a function to draw the polyline and assign
     the path of the polyline along with stroke colour / width
     and then the path behind the user assign a different colour
     to show progress of the the user going towards the destination
     */
    func drawPolyline(fromEncodedPath encodedPath: String)
    {
        guard let path = GMSPath(fromEncodedPath: encodedPath) else
        {
            #if DEBUG
            print("[DEBUG] Failed to decode polyline")
            #endif
            return
        }

        // Clear any previous polylines
        currentPolyline?.map = nil

        // Create and assign the new polyline
        let polyline = GMSPolyline(path: path)
        polyline.strokeWidth = 9.0
        polyline.strokeColor = customColour.returnSecondaryUIColour()
        polyline.map = mapView

        currentPolyline = polyline
    }
 
    
    //MARK: - Calculate Distance
    /*
     Calculate the distance between source (user's  location) and destination 
     (selected place's location) and then return a CLLocationDistance value
     */
    func calculateDistance(from source: CLLocationCoordinate2D, to destination: CLLocationCoordinate2D) -> CLLocationDistance
    {
        let sourceLocation = CLLocation(latitude: source.latitude, longitude: source.longitude)
        let destinationLocation = CLLocation(latitude: destination.latitude, longitude: destination.longitude)
        return sourceLocation.distance(from: destinationLocation)
    }
    //MARK: - Adjust Camera Zoom Dynamically
    /*
     This function changes the camera zoom dynamically based on how
     far away the user is to the destination and set the camera
     zoom for the map.
     */
    func adjustCameraZoomDynamically(userCoordinate: CLLocationCoordinate2D, destinationCoordinate: CLLocationCoordinate2D)
    {
        let bounds = GMSCoordinateBounds(coordinate: userCoordinate, coordinate: destinationCoordinate)
        let update = GMSCameraUpdate.fit(bounds, withPadding: 80)
        mapView.moveCamera(update)
    }


    //MARK: - Calculate Zoom Level Dynamically
    /*
     This function calculates the camera zoom level dynamically with the range
     of max and min zoom and adjust the camera zoom from the distance in kilometers
     and calculate the zoom and return the zoom.
     */
    func calculateZoomLevelDynamically(distance: CLLocationDistance) -> Float
    {
        let maxZoom: Float = 22.0
        let minZoom: Float = 10.0 
        
        // Adjust zoom level dynamically based on distance
        let distanceInKilometers = distance / 1000.0 // Convert meters to kilometers
        let zoom = max(minZoom, maxZoom - log2(Float(distanceInKilometers) + 1)) // Adding 1 to avoid log(0)
        return zoom
    }
    //MARK: - Configure Top Navigation Bar
    /*
     Change the top of the navigation bar for this view only and
     change the background colour to black and include a bottom
     border colour of my custom colour class.
     */
    func configureTopNavigationBar()
    {
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        let bottomBorder = CALayer()
        bottomBorder.backgroundColor = customColour.returnDefaultCGColour()
        bottomBorder.frame = CGRect(x: 0, y: navigationController?.navigationBar.frame.height ?? 0 - 1, width: navigationController?.navigationBar.frame.width ?? 0, height: 1)
        navigationController?.navigationBar.layer.addSublayer(bottomBorder)
    }
    //MARK: - Configure Google Maps Directions Display
    /*
     Configure the display of Google Maps to host the
     ability to show directions to the user.
     */
    func configureGoogleMapsDirectionsDisplay()
    {
        let LOCATION = UserCoordinatesManager.shared.getUserCoordinates()!
        let CAMERA = GMSCameraPosition.camera(
            withLatitude: LOCATION.latitude,
            longitude: LOCATION.longitude,
            zoom: 22.0
        )
        
        mapView = GMSMapView.map(withFrame: self.view.frame, camera: CAMERA)
        
        // Configure gestures
        mapView.settings.zoomGestures = true
        mapView.settings.scrollGestures = true
        mapView.settings.rotateGestures = true
        mapView.settings.tiltGestures = false

        GoogleMapManager.shared.initializeMap(on: mapView)
        GoogleMapManager.shared.setMapStyle()
        view.addSubview(mapView)
        configureGetDirectionsGoogleMapsConstraints()
        
        mapView.animate(to: CAMERA) 
    }

    //MARK: - Configure Destination
    /*
     Configure the destination by configuring the latitude and longitude
     and adding a finish line icon to the destination to show the user
     where the destination is and add the configured destination icon
     to the map.
     */
    func configureDestinationIcon()
    {
        if directionMarker == nil
        {
            let directionCoordinates = CLLocationCoordinate2D(latitude: place.latitude, longitude: place.longitude)
            directionMarker = GMSMarker(position: directionCoordinates)
            // Create a symbol configuration with desired size
            let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: 120)
            // Create a UIImage with the system icon and apply the symbol configuration
            guard let originalMarkerImage = UIImage(systemName: "flag.checkered")?.withConfiguration(symbolConfiguration) else { return }
            // Create a new image with the desired color
            guard let whiteMarkerImage = originalMarkerImage.imageWithColour(colour: .white) else { return }
            directionMarker?.icon = whiteMarkerImage
            directionMarker?.map = mapView
        }
        else
        {
          // else direction marker is not nil
        }
    }
  
}
