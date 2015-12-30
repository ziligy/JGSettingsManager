//
//  SettingsTable.swift
//
//  Created by Jeff on 12/27/15.
//  Copyright © 2015 Jeff Greenberg. All rights reserved.
//
//
// ==================== EXAMPLE SETTINGS PAGE ============================
//
// ------------- modify/replace this page with your settings -------------
//
//  SETTINGS STORAGE MODEL: example of the Storage Defaults using JGUserDefault
//  SETTINGS SECTIONS DISPLAY: example of display Sections using the SettingsCell types
//
//

import UIKit
import MapKit
import JGSettingsManager

/// SETTINGS STORAGE MODEL
/// user defined struct that contains the JGUserDefaults
struct LocationOptions {
    
    /// each JGUserDefault's type is defined based on the default value initially assigned
    
    let mapType = JGUserDefault (key: "mapTypeIndex", defaultValue: "standard") // String
    
    let zoomLevel = JGUserDefault (key: "zoomLevel", defaultValue: 10) // Int
    
    let displayLocationPin = JGUserDefault (key: "displayLocationPin", defaultValue: true) // Bool
    
    let displayPizzaLocations = JGUserDefault (key: "displayPizzaLocations", defaultValue: false) // Bool
    
    let userName = JGUserDefault (key: "userName", defaultValue: "") // String, empty to start
    
    let userGenderIndex = JGUserDefault (key: "userGenderIndex", defaultValue: 2) // Int
}


/// SETTINGS SECTIONS DISPLAY
/// Inherit JGSettingsTableController and implement SettingsSectionsData protocol
/// Load and return an array of Section data types to the controller's superclass
/// UserDefaults storage structure is instantiated and passed into settings cells
class SettingsTable: JGSettingsTableController, SettingsSectionsData {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableSections = loadSectionsConfiguration()
    }
    
    /// loads and returns the sections array
    /// used by JGSettingManager - TableController to build settings display
    internal func loadSectionsConfiguration() -> [Section] {
        
        let userDefaults = LocationOptions()
        
        let sections = [
            
            // using SegmentedControlTableCell with String type for storage value
            Section (
                header: "Map Type",
                footer: "",
                settingsCells: [
                    SegmentedControlTableCell(stringValue: userDefaults.mapType, segments: ["standard","satellite","hybrid"]),
                ],
                heightForFooter: 10.0
            ),
            
            // stepper table to save Int type
            Section (
                header: "Map Zoom Level",
                footer: "Initial zoom level for map",
                settingsCells: [
                    StepperTableCell(stepperData: userDefaults.zoomLevel, minimumValue: 1, maximumValue: 30)
                ]
            ),
            
            // switch table cell to store Bool type
            Section (
                header: "Map Display",
                footer: "Select the elements to display on the map",
                settingsCells: [
                    SwitchTableCell (switchData: userDefaults.displayLocationPin, label: "Display location pin"),
                    SwitchTableCell (switchData: userDefaults.displayPizzaLocations, label: "Display pizza locations")
                ],
                heightForHeader: 50.0,
                heightForFooter: 60.0
            ),
            
            // text table cell to store freeform String type
            Section (
                header: "User Name",
                footer: "",
                settingsCells: [
                    TextTableCell(textData: userDefaults.userName, placeholder: "user name")
                ],
                heightForFooter: 10.0
            ),
            
            // using SegmentedControlTableCell with Int type for storage value
            Section (
                header: "Gender",
                footer: "",
                settingsCells: [
                    SegmentedControlTableCell (index: userDefaults.userGenderIndex, segments: ["male","female","other"])
                ],
                heightForFooter: 10.0
            )
        ]
        
        return sections
    }
    
}
