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
        let potentialItem = Reminder(name: "Newest reminder", photo: nil, rating: 5)
        XCTAssertNotNil(potentialItem)
        
        // Failure cases.
        let noName = Reminder(name: "", photo: nil, rating: 0)
        XCTAssertNil(noName, "Empty name is invalid")
        
        let badRating = Reminder(name: "Really bad rating", photo: nil, rating: -1)
        XCTAssertNil(badRating, "Negative rating is invalid; be positive!")
    }
    
}
