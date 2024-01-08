/*
 Project:           Spontaneous
 File:              SettingStructs.swift
 Created:           24/08/2023
 Author:            John Michael Crawley
 
 Description:
 This feel creates the structs for the settings
 view controller. It tells the view controller
 data including sections, setting option type,
 etc.
*/
//MARK: - Import List
import UIKit
//MARK: - Sections
struct Sections
{
    let title: String
    let options: [SettingsOptionType]
}
//MARK: - Enum Settings Option Type
enum SettingsOptionType 
{
    case staticCell(model: SettingsOptions)
    case switchCell(mode: SettingsSwitchOption)
}
//MARK: - Settings Switch Option
struct SettingsSwitchOption
{
    let title: String
    let icon: UIImage?
    let iconBackgroundColour: UIColor
    let handler: (() -> Void)
    let isOn: Bool
}
//MARK: - Settings Option Struct
struct SettingsOptions
{
    let title: String
    let icon: UIImage?
    let iconBackgroundColour: UIColor
    let handler: (() -> Void)
}
