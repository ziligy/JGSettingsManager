//
//  TextTableCell.swift
//  JGSettingsManager
//
//  Created by Jeff on 12/21/15.
//  Copyright © 2015 Jeff Greenberg. All rights reserved.
//

import UIKit

public class TextTableCell: UITableViewCell, UITextFieldDelegate {
    
    // MARK: Data
    
    private var data: JGUserDefault<String>!
    
    //  MARK: UI
    
    private let textField = UITextField()
    
    // MARK: Init
    
    public convenience init (textData: JGUserDefault<String>, placeholder: String) {
        self.init()
        
        self.data = textData
        self.setupViews()
        self.initializeUI(placeholder)
    }
    
    private func setupViews() {
        textField.delegate = self
        addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func initializeUI(placeholder: String) {
        textField.placeholder = placeholder
        textField.text = data.value()
    }
    
    public func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.endEditing(true)
        save()
        return false
    }
    
    // MARK: Save
    
    public func save() {
        data.save(textField.text!)
    }
    
    //  MARK: Constraints
    
    override public func layoutSubviews() {
        updateConstraints()
    }
    
    override public func updateConstraints() {
        
        textField.leadingAnchor.constraintEqualToAnchor(leadingAnchor, constant: 10).active = true
        textField.centerYAnchor.constraintEqualToAnchor(centerYAnchor, constant: 0).active = true
        
        super.updateConstraints()
    }
    
    
}

