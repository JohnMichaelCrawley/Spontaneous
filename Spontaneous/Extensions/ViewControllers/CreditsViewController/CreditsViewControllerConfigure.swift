/*
 Project:           Spontaneous
 File:              CreditsViewControllerConfigure.swift
 Created:           06/09/2023
 Author:            John Michael Crawley
 
 Description:
 This file configures the data inside the credits
 table view. 
 */
//MARK: - Import List
import UIKit
//MARK: - Credits View Controller Extension - Configure
extension CreditsViewController
{
    //MARK: - Configure Table View Items
    func configureTableViewItems()
    {
        // Developer
        creditsViewModel.models.append(CreditsSections(title: "Developer", options:
        [
            .staticCell(model: CreditsOptions(name: "John Crawley", role: "Developer"))
        ]))
        //Localisation
        creditsViewModel.models.append(CreditsSections(title: "Localisation", options:
        [
            .staticCell(model: CreditsOptions(name: "Chise Negishi", role: "Japanese")),
            .staticCell(model: CreditsOptions(name: "Name", role: "Role")),
            .staticCell(model: CreditsOptions(name: "Name", role: "Role")),
            .staticCell(model: CreditsOptions(name: "Name", role: "Role"))
        ]))
        //Misc
        creditsViewModel.models.append(CreditsSections(title: "Quality Assurance", options:
        [
            .staticCell(model: CreditsOptions(name: "Name", role: "Role"))
        ]))
    }
}
