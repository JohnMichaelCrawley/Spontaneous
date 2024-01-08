/*
 Project:           Spontaneous
 File:              SettingsViewModel.swift
 Created:           24/08/2023
 Author:            John Michael Crawley
 
 Description:
 This file handles returning any data
 from the models structs for the settings
 menu and send it to the view controller
 
*/
//MARK: - Import list
import Foundation
import UIKit
//MARK: - Settings View Model
class SettingsViewModel
{
    //MARK: - Variables
    var models = [Sections]()
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
                withIdentifier: SettingsTableViewCell.INDENTIFER,
                for: indexPath
            ) as? SettingsTableViewCell else
            {
                return UITableViewCell()
            }
            cell.configure(with: model)
            return cell
        case .switchCell(mode: let model):
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: SwitchTableViewCell.INDENTIFER,
                for: indexPath
            ) as? SwitchTableViewCell else
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
        let type = models[indexPath.section].options[indexPath.row]
        
        switch type.self
        {
        case .staticCell(model: let model):
            model.handler()
        case .switchCell(mode: let model):
            model.handler()
        }
    }
}
