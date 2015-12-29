//
//  JGSettingsTableViewController.swift
//  JGSettingsManager
//
//  Created by Jeff on 12/14/15.
//  Copyright © 2015 Jeff Greenberg. All rights reserved.
//

import UIKit

/// model for sections display
/// used by JGSettingManager - TableController to build settings display
public struct Section {
    
    private let header: String
    private let footer: String
    private let settingsCells: [UITableViewCell]
    private let heightForHeader: CGFloat
    private let heightForFooter: CGFloat
    
    // can't use default initializer with default assignments
    public init(
        header: String,
        footer: String,
        settingsCells: [UITableViewCell],
        heightForHeader: CGFloat = 40.0,
        heightForFooter: CGFloat = 40.0)
    {
        self.header = header
        self.footer = footer
        self.settingsCells = settingsCells
        self.heightForHeader = heightForHeader
        self.heightForFooter = heightForFooter
    }
}

public protocol SettingsSectionsData {
    func loadSectionsConfiguration() -> [Section]
}


/// main controller for JGSettingsManager
public class JGSettingsTableController: UITableViewController {
    
    public var tableSections = [Section]()
    
    // styling should be set to Grouped in storyboard (initialization)
    // if not emebeded in storyboard Nav or coded without storyboard
    // then un-comment this:
    //    convenience required init(coder aDecoder: NSCoder) {
    //        self.init(style: .Grouped)
    //    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.allowsSelection = false
    }

    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return tableSections.count
    }

    override public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableSections[section].settingsCells.count
    }
    
    override public func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return tableSections[section].header
    }
    
    override public func tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return tableSections[section].footer
    }
    
    override public func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if tableSections[section].heightForHeader == 0 { return 0.00001 } // compensate for 0.0 not being allowed to hide headers
        return tableSections[section].heightForHeader 
    }
    
    override public func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if tableSections[section].heightForFooter == 0 { return 0.00001 }  // compensate for 0.0 not being allowed to hide footers
        return tableSections[section].heightForFooter
    }
    
    override public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
         return tableSections[indexPath.section].settingsCells[indexPath.row]
    }
    
}
