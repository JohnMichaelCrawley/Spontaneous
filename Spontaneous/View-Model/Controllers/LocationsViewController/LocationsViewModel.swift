/*
 Project:           Spontaneous
 File:              LocationsViewModel.swift
 Created:           31/08/2023
 Author:            John Michael Crawley
 
 Description:
 This file handles returning any data
 from the models structs for the settings
 menu and send it to the view controller
 */
//MARK: - Import list
import UIKit
//MARK: - Locations View Model
class LocationsViewModel
{
    //MARK: - Variables
    var model = [LocationsSwitchOption]()
    //MARK: - Return the number of Rows
    func numberOfRows(numberOfRowsInSection section: Int) -> Int
    {
        return model.count
    }
    //MARK: - Table View - Cell For Row At
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell 
    {
        let model = model[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: LocationsTableViewCell.INDENTIFER,
            for: indexPath
        ) as? LocationsTableViewCell else
        {
            return UITableViewCell()
        }
        cell.configureLocations(with: model)
        return cell
    }
    //MARK: - Did Select Row At
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) 
    {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
