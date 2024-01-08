/*
 Project:           Spontaneous
 File:              CreditsViewModel.swift
 Created:           01/09/2023
 Author:            John Michael Crawley
 
 Description:
 This file handles returning any data from the models
 structs for the credits view controller
 and send it to the view controller
 */
//MARK: - Import list
import Foundation
import UIKit
//MARK: - Credits View Model
class CreditsViewModel
{
    //MARK: - Variables
    var models = [CreditsSections]()
    //MARK: - Return the number of Sections
    func numberOfSections() -> Int
    {
        return models.count
    }
    //MARK: - Return the number of Rows
    func numberOfRows(numberOfRowsInSection section: Int) -> Int
    {
        return models[section].options.count
    }
    //MARK: - Return the Title for Headers in Sections
    func titleForHeaderInSection(titleForHeaderInSection section: Int) -> String?
    {
        return models[section].title
    }
    //MARK: - Table View - Cell For Row At
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell 
    {
        let model = models[indexPath.section].options[indexPath.row]
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
            return cell
        }
    }
    //MARK: - Did Select Row At
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

