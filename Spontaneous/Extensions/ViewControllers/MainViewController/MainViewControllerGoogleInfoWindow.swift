/*
 Project:           Spontaneous
 File:              MainViewControllerGoogleInfoWindow.swift
 Created:           17/10/2023
 Author:            John Michael Crawley
 
 Description:
 This file configures the info window when displaying information
 to the user. This sets the info window to the custom window view
 I have made called, 'GoogleInfoWindowView'
 */
//MARK: - Import list
import GoogleMaps

//MARK: - Main View Controller Extension - GMS Map View Delegate
extension MainViewController : GMSMapViewDelegate
{
    //MARK: - Did Tap Window Of
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker)
    {
        //  print("didTapInfoWindowOf")
    }
    //MARK: - Did Long Press Info Window Of
    func mapView(_ mapView: GMSMapView, didLongPressInfoWindowOf marker: GMSMarker)
    {
        // print("didLongPressInfoWindowOf")
    }
    // This method is called when the map is tapped.
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D)
    {
        // Prevent the info window from closing when tapping off the marker
        mapView.selectedMarker = marker
    }
    //MARK: - Marker Info Window
    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView?
    {
        // Create the custom info window once
        guard let customInfoWindow = customInfoWindow(), let place = marker.userData as? Place else {return nil}
        // Check if the place type is allowed based on switches turned on
        let allowedTypes = PlacesManager().findUILocationSwitchesTurnedOn()
        // Filter out types that are not in allowedTypes
        let filteredPlaceTypes = place.types.filter { allowedTypes.contains($0) }
        // Setup the info window data
        customInfoWindow.placeName = place.name
        customInfoWindow.placeRating = "Rating: \(place.rating)"
        customInfoWindow.placeType = "Type/s: \(filteredPlaceTypes)".replacingOccurrences(of: "[", with: "").replacingOccurrences(of: "]", with: "").replacingOccurrences(of: "\"", with: "")
        // Load the first image into the photoImageView asynchronously
        if let firstPhoto = place.photo.first 
        {
            loadPhoto(from: firstPhoto) 
            { image in
                DispatchQueue.main.async
                {
                    customInfoWindow.placePhoto = image
                }
            }
        }
        // Set the custom view UI data and constraints
        configureCustomInfoWindowView()
        configureGetDirectionsButton()
        getDirectionsButton!.alpha = 0.0 // set alpha to 0 which allows it to fade in
        // Fade in the button
        getDirectionsButton!.fadeIn()
        // Add customView as a subview to mapView
        mapView.addSubview(customView!)
        mapView.addSubview(getDirectionsButton!)
        // Add target for button tap
        getDirectionsButton!.addTarget(self, action: #selector(getDirectionsToRandomlySelectedPlace), for: .touchUpInside)
        // Info Window Corner Radius
        customInfoWindow.layer.cornerRadius = 10
        // Border
        customInfoWindow.layer.borderWidth = 0.5
        customInfoWindow.layer.borderColor = UIColor.lightGray.cgColor
        // Return Info Window
        return customInfoWindow
    }
    // MARK: - loadPhoto - Function to load an image from a Photo object asynchronously
    func loadPhoto(from photo: Photo, completion: @escaping (UIImage?) -> Void)
    {
        let imageURL = URL(string: "https://maps.googleapis.com/maps/api/place/photo?maxwidth=200&photoreference=\(photo.photoReference)&key=\(GoogleAPIManager.shared.returnAPIKey())")
        let task = URLSession.shared.dataTask(with: imageURL!) { (data, response, error) in
            guard let data = data, error == nil else 
            {
                completion(nil)
                return
            }
            let image = UIImage(data: data)
            completion(image)
        }
        task.resume()
    }
    // MARK: - Get Directions To Randomly Selected Place
    @objc func getDirectionsToRandomlySelectedPlace()
    {
        // Present the get directions
        let getDirections = GetDirectionsViewController()
        getDirections.hidesBottomBarWhenPushed = true
        
        self.navigationController?.pushViewController(getDirections, animated: true)
    }
    //MARK: - Did Tap
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool { return false }
}
