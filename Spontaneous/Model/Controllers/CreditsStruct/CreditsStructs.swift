/*
 Project:           Spontaneous
 File:              CreditsStructs.swift
 Created:           01/09/2023
 Author:            John Michael Crawley
 
 Description:
 This model creates cases for each product
 tier subscription inside the application
*/
//MARK: - Sections
struct CreditsSections
{
    let title: String
    let options: [CreditsOptionType]
}
//MARK: - Enum Settings Option Type
enum CreditsOptionType
{
    case staticCell(model: CreditsOptions)
}
//MARK: - Settings Switch Option
struct CreditsOptions
{
    let name: String
    let role: String
}
