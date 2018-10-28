//
//  _0181026_SushreeSangitaN_NYCSchoolsUITests.swift
//  20181026-SushreeSangitaN-NYCSchoolsUITests
//
//  Created by Sangita on 10/26/18.
//  Copyright © 2018 SushreeSangitaN. All rights reserved.
//

import XCTest

class _0181026_SushreeSangitaN_NYCSchoolsUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    func testSchoolDetail()  {
        
        let app = XCUIApplication()
        let schoolListTable=app.tables["schoolListTable"]
        schoolListTable.cells.staticTexts["Clinton School Writers & Artists, M.S. 260"].tap()
        app.navigationBars["School Details"].buttons["School List"].tap()
                
    }

}
