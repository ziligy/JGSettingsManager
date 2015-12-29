//
//  StepperTableCell.swift
//  JGSettingsManager
//
//  Created by Jeff on 12/21/15.
//  Copyright © 2015 Jeff Greenberg. All rights reserved.
//

import UIKit

public class StepperTableCell: UITableViewCell {
    
    // MARK: Data
    
    private var dataInt: JGUserDefault<Int>!
    private var dataDouble: JGUserDefault<Double>!
    
    //  MARK: UI
    
    private let stepper = UIStepper()
    private let label = UILabel()
    private let stackView = UIStackView()
    
    // MARK: Init
    
    public convenience init (stepperData: JGUserDefault<Int>, minimumValue: Int, maximumValue: Int) {
        self.init()
        
        self.dataInt = stepperData
        self.setupViews()
        self.initializeUIforInt(minimumValue, maximumValue)
    }
    
    public convenience init (stepperData: JGUserDefault<Double>, minimumValue: Double, maximumValue: Double) {
        self.init()
        
        self.dataDouble = stepperData
        self.setupViews()
        self.initializeUIforDouble(minimumValue, maximumValue)
    }
    
    private func setupViews() {
        
        label.font = UIFont.monospacedDigitSystemFontOfSize(30, weight: UIFontWeightMedium)
        stepper.addTarget(self, action: Selector("save:"), forControlEvents: .ValueChanged)
        
        stackView.spacing = 12.0
        
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(stepper)

        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
     }
    
    private func initializeUIforInt(minimumValue: Int, _ maximumValue: Int) {
        stepper.minimumValue = Double(minimumValue)
        stepper.maximumValue = Double(maximumValue)
        stepper.value = Double(dataInt.value())
        label.text = String(dataInt.value())
     }
    
    private func initializeUIforDouble(minimumValue: Double, _ maximumValue: Double) {
        stepper.minimumValue = minimumValue
        stepper.maximumValue = maximumValue
        stepper.value = dataDouble.value()
        label.text = String(dataDouble.value())
    }
    
    // MARK: Save
    
    public func save(sender: UIStepper) {
        if dataDouble == nil {
            label.text = Int(sender.value).description
            dataInt.save(Int(sender.value))
        } else {
            label.text = sender.value.description
            dataDouble.save(sender.value)
        }
    }
    
    //  MARK: Constraints
    
    override public func layoutSubviews() {
        updateConstraints()
    }
    
    override public func updateConstraints() {
        
        stackView.centerYAnchor.constraintEqualToAnchor(centerYAnchor, constant: 0).active = true
        stackView.centerXAnchor.constraintEqualToAnchor(centerXAnchor, constant: 0).active = true
        
        super.updateConstraints()
    }
    
    
}
