//
//  Reminder.swift
//  iReminder
//
//  Created by Dylan Hellems on 2/22/16.
//

import UIKit

class Reminder {
    
    // MARK: Properties
    
    var name: String
    var dateTime: NSDate
    var description: String?
    
    // MARK: Initlialization
    init?(name: String, dateTime: NSDate, description: String) {
        // Initialize stored properties.
        self.name = name
        self.dateTime = dateTime
        self.description = description
        
        // Initialization should fail if there is no name
        if name.isEmpty {
            return nil
        }
    }
    
}