//
//  iReminderTests.swift
//  iReminderTests
//
//  Created by Dylan Hellems on 2/21/16.
//

import UIKit
import XCTest
@testable import iReminder

class iReminderTests: XCTestCase {
    
    // MARK: iReminder Tests
    
    // Tests to confirm that the Reminder initializer returns when no name or a negative rating is provided.
    func testReminderInitialization() {
        
        // Success case.
        let potentialItem = Reminder(name: "Newest reminder", dateTime: NSDate(), description: "")
        XCTAssertNotNil(potentialItem)
        
        // Failure cases.
        let noName = Reminder(name: "", dateTime: NSDate(), description: "")
        XCTAssertNil(noName, "Empty name is invalid")
    }
    
}
