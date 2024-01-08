/*
 Project:           Spontaneous
 File:              LanguagesViewControllerExtension.swift
 Created:           01/09/2023
 Author:            John Michael Crawley
 
 Description:
 This file is an extension to the language view controller
 and setup the tableview from the language view model.
 */
//MARK: - Import List
import UIKit
//MARK: - Languages View Controller Extension - Table View
extension LanguagesViewController: UITableViewDelegate, UITableViewDataSource
{
    // MARK: - Number of Rows In Selection
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        languageViewModel.returnLanguageCount()
    }
    // MARK: - Cell For Row At
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell 
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LanguageCell", for: indexPath)
        cell.textLabel?.text = languageViewModel.returnLanguageRawValue(at: indexPath)
        
        if let selectedLanguageIndex = languageViewModel.selectedLanguageIndex, selectedLanguageIndex == indexPath.row 
        {
            cell.accessoryType = .checkmark
        }
        else
        {
            cell.accessoryType = .none
        }
        return cell
    }
    // MARK: UITableViewDelegate methods
    //MARK: - Did Select Row At
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        languageViewModel.selectLanguage(at: indexPath)
        tableView.reloadData()
    }
}

