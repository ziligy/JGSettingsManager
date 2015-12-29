//
//  SegmentedControlTableCell.swift
//  JGSettingsManager
//
//  Created by Jeff on 12/22/15.
//  Copyright © 2015 Jeff Greenberg. All rights reserved.
//

import UIKit

public class SegmentedControlTableCell: UITableViewCell {
    
    // MARK: Data
    
    private var dataInt: JGUserDefault<Int>!
    private var dataString: JGUserDefault<String>!
    
    //  MARK: UI
    
    private let segmentedControl = UISegmentedControl()
    
    // MARK: Init
    
    public convenience init (index: JGUserDefault<Int>, segments: [String]) {
        self.init()
        
        dataInt = index
        setupViews()
        initializeUIforInt(segments)
    }

    public convenience init (stringValue: JGUserDefault<String>, segments: [String]) {
        self.init()

        dataString = stringValue
        setupViews()
        initializeUIforString(segments)
    }
    
    private func setupViews() {
        
        addSubview(segmentedControl)
        
        segmentedControl.setFontSize(20)
        
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.addTarget(self, action: Selector("save:"), forControlEvents: .ValueChanged)
    }
    
    private func initializeUIforInt(segments: [String]) {
        
        for (index, segment) in segments.enumerate() {
            segmentedControl.insertSegmentWithTitle(segment, atIndex: index, animated: false)
        }
        
        segmentedControl.selectedSegmentIndex = dataInt.value()
    }
    
    private func initializeUIforString(segments: [String]) {
        
        var selectedSegmentIndex = 0
        let stringValue = dataString.value()
        
        for (index, segment) in segments.enumerate() {
            if segment == stringValue { selectedSegmentIndex = index }
            segmentedControl.insertSegmentWithTitle(segment, atIndex: index, animated: false)
        }
        
        // set the default to zero to avoid error
        // it is initiailied to -1 by iOS
        segmentedControl.selectedSegmentIndex = selectedSegmentIndex
    }
    
    // MARK: Save

    public func save(sender: UISegmentedControl) {
        
        if dataString == nil {
            dataInt.save(sender.selectedSegmentIndex)
        } else {
            dataString.save(sender.titleForSegmentAtIndex(sender.selectedSegmentIndex)!)
        }
    }
    
    //  MARK: Constraints
    
    override public func layoutSubviews() {
        updateConstraints()
    }
    
    override public func updateConstraints() {
        
        segmentedControl.centerYAnchor.constraintEqualToAnchor(centerYAnchor, constant: 0).active = true
        segmentedControl.centerXAnchor.constraintEqualToAnchor(centerXAnchor, constant: 0).active = true
        
        super.updateConstraints()
    }
}

extension UISegmentedControl {
    
    func setFontSize(fontSize: CGFloat) {

        let normalTextAttributes: [NSObject : AnyObject] = [
            NSForegroundColorAttributeName: UIColor.blackColor(),
            NSFontAttributeName: UIFont.systemFontOfSize(fontSize, weight: UIFontWeightRegular)
        ]
        
        let boldTextAttributes: [NSObject : AnyObject] = [
            NSForegroundColorAttributeName : UIColor.whiteColor(),
            NSFontAttributeName : UIFont.systemFontOfSize(fontSize, weight: UIFontWeightMedium)
        ]
        
        self.setTitleTextAttributes(normalTextAttributes, forState: .Normal)
        self.setTitleTextAttributes(normalTextAttributes, forState: .Highlighted)
        self.setTitleTextAttributes(boldTextAttributes, forState: .Selected)
    }
}


