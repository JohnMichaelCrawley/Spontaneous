/*
 Project:           Spontaneous
 File:              LanguageModel.swift
 Created:           04/09/2023
 Author:            John Michael Crawley
 
 Description:
 This model creates cases for each product
 tier subscription inside the application
 
*/
// MARK: - Language Model
enum LanguageModel: String, CaseIterable
{
    // MARK: - Language Cases
    case English
    case Japanese
    case Cantonese
    case Mandarin
    case Italian
    // MARK: - Return Language Count
    static func returnLanguageCount() -> Int
    {
        return self.allCases.count
    }
}
