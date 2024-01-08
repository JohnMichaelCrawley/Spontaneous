/*
 Project:           Spontaneous
 File:              CreditsViewControllerExtension.swift
 Created:           01/09/2023
 Author:            John Michael Crawley
 
 Description:
 This file gets data from the view-model and setup all
 the information on the table view. 
*/
//MARK: - Import List
import UIKit
//MARK: - Settings View Controller Extension
extension CreditsViewController: UITableViewDelegate, UITableViewDataSource
{
    //MARK: - Title For Header In Section (Title of the table view)
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        return creditsViewModel.titleForHeaderInSection(titleForHeaderInSection: section)
    }
    
    //MARK: -  Number of Sections
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return creditsViewModel.numberOfSections()
    }
    //MARK: - Table View - Number of Rows In Selection
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return creditsViewModel.numberOfRows(numberOfRowsInSection: section)
    }
    //MARK: - Table View - Cell For Row At
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = creditsViewModel.models[indexPath.section].options[indexPath.row]
    
        switch model.self
        {
        case .staticCell(model: let model):
            guard let cell = tableView.dequeueReusableCell(
               
                withIdentifier: CreditsTableViewCell.INDENTIFER,
                for: indexPath
            ) as? CreditsTableViewCell else
            {
                return UITableViewCell()
            }
            cell.configure(with: model)
            cell.isUserInteractionEnabled = false
            // Set the corner radius for the cell's content view
            cell.layer.cornerRadius = 8.5
            cell.clipsToBounds = true
            return cell
        }
    }
    //MARK: - Did Select Row At
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
    }

}
