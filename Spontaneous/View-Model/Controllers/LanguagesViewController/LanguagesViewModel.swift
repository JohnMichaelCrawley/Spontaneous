/*
 Project:           Spontaneous
 File:              LanguagesViewModel.swift
 Created:           04/09/2023
 Author:            John Michael Crawley
 
 Description:
 This view-model is for the languages view
 controller to enable data from the langauges
 model to the view. It acts as a middle-man.
 */
// MARK: - Import List
import Foundation
// MARK: - Languages View Model
class LanguagesViewModel
{
    //MARK: - Variables
    var selectedLanguageIndex: Int?
    //MARK: - INIT - Initalise the index for the selected row with UserDefaults
    init()
    {
        if let savedIndex = UserDefaults.standard.value(forKey: "SelectedLanguageIndex") as? Int {
            selectedLanguageIndex = savedIndex
        }
    }
    //MARK: - Selected Language
    func selectLanguage(at indexPath: IndexPath)
    {
        guard indexPath.row >= 0, indexPath.row < LanguageModel.returnLanguageCount() else
        {
            return
        }
        selectedLanguageIndex = indexPath.row
        UserDefaults.standard.set(selectedLanguageIndex, forKey: "SelectedLanguageIndex")
    }
    // MARK: - Return Language Count From Model
    func returnLanguageCount() -> Int
    {
        return LanguageModel.returnLanguageCount()
    }
    // MARK: - Return Language Raw Value
    func returnLanguageRawValue(at indexPath: IndexPath) -> String? 
    {
        // Ensure the selectedLanguageIndex is within the bounds of LANGUAGES array
        guard indexPath.row >= 0, indexPath.row < LanguageModel.returnLanguageCount() 
        else
        {
            return nil
        }
        let language = LanguageModel.allCases[indexPath.row]
        return language.rawValue
    }
}
