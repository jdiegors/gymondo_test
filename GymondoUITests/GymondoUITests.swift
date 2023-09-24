//
//  GymondoUITests.swift
//  GymondoUITests
//
//  Created by Juan Diego Rodriguez Steller on 19/9/23.
//

import XCTest

final class GymondoUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        
        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        app = nil
    }

    func test_isDisplaying_exerciseList() throws {
        XCTAssertTrue(app.isDisplayingExerciseList)
    }
    
    func test_goTo_exerciseDetails() throws {
        app.collectionViews.cells.element(boundBy: 0).tap()
        XCTAssertNotNil(app.scrollViews["variations"])
    }
    
    func test_goTo_exerciseDetail_openVariant() throws {
        app.collectionViews.cells.element(boundBy: 0).tap()
        app.scrollViews["variations"].tap()
        XCTAssertNotNil(app.scrollViews["variations"])
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
