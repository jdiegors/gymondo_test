//
//  Displaying .swift
//  GymondoUITests
//
//  Created by Juan Diego Rodriguez Steller on 23/9/23.
//

import XCTest

extension XCUIApplication {
    var isDisplayingExerciseList: Bool {
        return otherElements["exerciseList"].exists
    }
    
    var isDisplayingExerciseDetails: Bool {
        return otherElements["exerciseDetails"].exists
    }
}
