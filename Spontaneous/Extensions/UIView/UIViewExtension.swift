/*
 Project:           Spontaneous
 File:              UIViewExtension.swift
 Created:           15/01/2024
 Author:            John Michael Crawley
 
 Description:
 This file handles the UI View fade in / fade out
 for UI elements like buttons, labels etc.
*/
//MARK: - Import List
import UIKit
//MARK: UI View Extension
extension UIView
{
    //MARK: - Fade In (Fade In UI Elements)
    func fadeIn(duration: TimeInterval = 1.9, completion: ((Bool) -> Void)? = nil) 
    {
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 1.0
        }, completion: completion)
    }
    //MARK: - Fade Out (Fade Out UI Elements)
    func fadeOut(duration: TimeInterval = 0.3, completion: ((Bool) -> Void)? = nil) {
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 0.0
        }, completion: completion)
    }
}
