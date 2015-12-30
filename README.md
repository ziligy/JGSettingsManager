# ![icon](https://raw.githubusercontent.com/ziligy/JGSettingsManager/master/jGSettingsManager-github.png "icon") JGSettingsManager

An easy-to-use settings manager to define, access, and store NSUserDefaults the Swift way.

#### Screen Shot from Example:

![example](https://raw.githubusercontent.com/ziligy/JGSettingsManager/master/ScreenShotExample.png "example")

## Installation
* via Carthage: github "ziligy/JGSettingsManager"
* or copy JGSettingsManager folder to your project

## Usage
* Declare storage items using JGUserDefault for each
* Select a SettingsCell UI component for each item
* Create Sections array to load into the Manager

```
import JGSettingsManager

struct UserDefaults {
    let mapType = JGUserDefault (key: "mapTypeIndex", defaultValue: "standard") // String
    let zoomLevel = JGUserDefault (key: "zoomLevel", defaultValue: 10) // Int
}

class SettingsTable: JGSettingsTableController, SettingsSectionsData {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableSections = loadSectionsConfiguration()
    }

    internal func loadSectionsConfiguration() -> [Section] {

        let userDefaults = UserDefaults()

        let sections = [

            Section (
                header: "Map Type",
                footer: "",
                settingsCells: [
                    SegmentedControlTableCell(stringValue: userDefaults.mapType, segments: ["standard","satellite","hybrid"]),
                ],
                heightForFooter: 10.0
            ),

            Section (
                header: "Map Zoom Level",
                footer: "Initial zoom level for map",
                settingsCells: [
                    StepperTableCell(stepperData: userDefaults.zoomLevel, minimumValue: 1, maximumValue: 30)
                ]
            )]

        return sections
    }
}
```
* Add TableController to Storyboard
* Assign SettingsTable as Custom Controller
* select Table style: **Grouped** for nice formatting

* **That's it!**

* The JGSettingsManager will save the user's values in NSUserDefaults for persistent storage even when the app is closed.

## Current Settings UI Cells & types
* Switch
    - Bool
* Text
    - String
* Stepper
    - Int
    - Double
* Segmented
    - Index as Int
    - String

*or define your own*

## Access Settings in App
* Use the JGUserDefault items
```
print(zoomLevel.value())
```
*prints the last value from the settings table or the default*

## Demo Example
***See attached Example project***

## Requirements
* Xcode 7.2
* Swift 2
* iOS 9.0+

## Related
* [Snap!Location](https://github.com/ziligy/SnapLocation) micro-app incorporating JGSettingsManager

