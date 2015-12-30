//
//  JGUserDefault.swift
//
//  Created by Jeff on 12/17/15.
//  Copyright © 2015 Jeff Greenberg. All rights reserved.
//

import Foundation

/// Generic struct to retrieve & save to NSUserDefaults
public struct JGUserDefault<T> {
    private let key: String
    private let defaultValue: T
    
    public init(key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }
    
    public func value(storage: NSUserDefaults = NSUserDefaults.standardUserDefaults()) -> T {
        return (storage.objectForKey(self.key) as? T ?? self.defaultValue)
    }
    
    public func save(newValue: T, storage: NSUserDefaults = NSUserDefaults.standardUserDefaults()) {
        storage.setObject((newValue as! AnyObject), forKey: self.key)
    }
}