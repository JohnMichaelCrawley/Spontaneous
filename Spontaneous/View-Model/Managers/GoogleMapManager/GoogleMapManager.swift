/*
 Project:           Spontaneous
 File:              GoogleMapManager.swift
 Created:           13/10/2023
 Author:            John Michael Crawley
 
 Description:
 This file handles a shared Google Map to be
 accessed or adjusted throughout the app and
 allow D.R.Y principles to allow this file
 be the single place the settings of the map
 to be made
*/
//MARK: - Imports
import Foundation
import GoogleMaps
//MARK: - Google Map Manager
class GoogleMapManager
{
    //MARK: - Variables
    static let shared = GoogleMapManager()
    var mapView: GMSMapView?
    //MARK: - INIT
    private init() { } // Ensure that only one instance can exist
    //MARK: - Initialise Map
    func initializeMap(on view: GMSMapView)
    {
        mapView = view
        mapView?.isMyLocationEnabled = true
        
        mapView?.translatesAutoresizingMaskIntoConstraints = false
        mapView?.settings.compassButton = true
        mapView?.settings.myLocationButton = false
        // Disable user interaction
        mapView?.isUserInteractionEnabled = true
        mapView?.settings.scrollGestures = false
        mapView?.settings.zoomGestures = false
    }
    //MARK: - Set Map Location
    func setMapLocation(latitude: Double, longitude: Double, zoom: Float)
    {
        if let mapView = mapView 
        {
            let camera = GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude, zoom: zoom)
            mapView.animate(to: camera)
        }
    } 
    // MARK: - Set Map Style (Reduces code repetition)
    private func setMapStyleFromBundle(resourceJSONFile: String)
    {
        if let mapView = mapView, let styleURL = Bundle.main.url(forResource: resourceJSONFile, withExtension: "json")
        {
            do
            {
                // Set the map style using JSON data
                let style = try GMSMapStyle(contentsOfFileURL: styleURL)
                mapView.mapStyle = style
            }
            catch
            {
                #if DEBUG
                print("Error setting map style: \(error.localizedDescription)")
                #endif
            }
        }
        else
        {
            #if DEBUG
            print("Invalid \(resourceJSONFile) style file or mapView is not initialized.")
            #endif
        }
    }
    //MARK: - Set Map Style (Configure if the map is dark or light mode)
    func setMapStyle()
    {
        let theme = ThemeViewModel.shared.returnCurrentTheme()
        if theme == "dark"
        {
            setMapStyleFromBundle(resourceJSONFile: "darkstyle")
        }
        else if theme == "light"
        {
            
            setMapStyleFromBundle(resourceJSONFile: "lightstyle")
        }
     }
}
