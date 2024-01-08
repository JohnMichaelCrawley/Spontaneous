/*
 Project:           Spontaneous
 File:              LocationsViewControllerExtension.swift
 Created:           31/08/2023
 Author:            John Michael Crawley
 
 Description:
 This file handles the table view data for the locations view
 controller getting the data (i.e) number of rows from the
 view model and reuturning the custom cell to the table view
*/
//MARK: - Import list
import UIKit
//MARK: - Locations View Controller Extension Table View
extension LocationsViewController: UITableViewDelegate, UITableViewDataSource
{
    //MARK: - Table View - Number of Rows In Selection
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return locationsViewModel.numberOfRows(numberOfRowsInSection: section)
    }
    //MARK: - Table View - Cell For Row At
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell 
    {
        let model = locationsViewModel.model[indexPath.row]
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
