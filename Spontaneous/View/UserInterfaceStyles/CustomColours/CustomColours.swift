/*
 Project:           Spontaneous
 File:              CustomColours.swift
 Created:           12/12/2022
 Author:            John Michael Crawley
 
 Description:
 This file uses DRY (Don't Repeat Yourself) principle
 to avoid repetition and allows adjustments for the colour
 in the single place
 */

//MARK: - Import List
import UIKit
// MARK: - Custom Colours 
class CustomColours
{
    //MARK: - Return Default UI Colour
    func returnDefaultUIColour() -> UIColor
    {
        // #51B4AF
        let colour = UIColor(red: 81/255, green: 180/255, blue: 175/255, alpha: 1.0)
        return colour
    }
    //MARK: - Return Secondary UI Colour
    func returnSecondaryUIColour() -> UIColor
    {
        // #357370
        let colour = UIColor(red: 53/255, green: 115/255, blue: 112/255, alpha: 1.0)
        return colour
    }
    //MARK: - Return Default CG Colour
    func returnDefaultCGColour () -> CGColor
    {
        let colour = CGColor(red: 81/255, green: 180/255, blue: 175/255, alpha: 1.0)
        return colour
    }
    //MARK: - Return Secondary CG Colour
    func returnSecondaryCGColour () -> CGColor
    {
        let colour = CGColor(red: 53/255, green: 115/255, blue: 112/255, alpha: 1.0)
        return colour
    }
}
