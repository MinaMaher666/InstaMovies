//
//  InstaMoviesUITests.swift
//  InstaMoviesUITests
//
//  Created by Mina Maher on 3/20/19.
//  Copyright © 2019 Mina Maher. All rights reserved.
//

import XCTest

class InstaMoviesUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUp() {
        continueAfterFailure = false

        app = XCUIApplication()
        app.launch()
    }

    override func tearDown() {
        app = nil
    }

    func testValidateAddNewMovie() {
        app/*@START_MENU_TOKEN@*/.segmentedControls.buttons["My Movies"]/*[[".segmentedControls.buttons[\"My Movies\"]",".buttons[\"My Movies\"]"],[[[-1,1],[-1,0]]],[1]]@END_MENU_TOKEN@*/.tap()
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .button).element.tap()
        app.buttons["Add Movie"].tap()
        // Test add new movie screen still visible
        XCTAssertTrue(app.buttons["Add Movie"].exists)
    }
    
    func testAddNewMovie() {
        app/*@START_MENU_TOKEN@*/.buttons["My Movies"]/*[[".segmentedControls.buttons[\"My Movies\"]",".buttons[\"My Movies\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .button).element.tap()
        
        app.scrollViews.otherElements.textFields["Movie Title"].tap()
        app.scrollViews.otherElements.textFields["Movie Title"].typeText("new movie")
        app.toolbars["Toolbar"].buttons["Done"].tap()
        
        let scrollViewsQuery = app.scrollViews
        scrollViewsQuery.otherElements.textFields["Release Date"].tap()
        let doneButton = app.toolbars["Toolbar"].buttons["Done"]
        doneButton.tap()
        
        scrollViewsQuery.otherElements.containing(.staticText, identifier:"Movie Title").children(matching: .textView).element.tap()
        scrollViewsQuery.otherElements.containing(.staticText, identifier:"Movie Title").children(matching: .textView).element.typeText("overview")
        doneButton.tap()
        app.buttons["Add Movie"].tap()
        
        // Assert That the new movie is added
        XCTAssertEqual(app.cells.count, 1)
    }

}
