//
//  _0181026_SushreeSangitaN_NYCSchoolsTests.swift
//  20181026-SushreeSangitaN-NYCSchoolsTests
//
//  Created by Sangita on 10/26/18.
//  Copyright © 2018 SushreeSangitaN. All rights reserved.
//

import XCTest
@testable import _0181026_SushreeSangitaN_NYCSchools

class _0181026_SushreeSangitaN_NYCSchoolsTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testSchoolDetail(){
        let schoolName = "Random School Name"
        let schoolDetailObj = SchoolDetailViewController()
        var stausCheck : Bool = false
        
        stausCheck=schoolDetailObj.schoolDetailAvailable(schoolName: schoolName)
       
        XCTAssertEqual(false, stausCheck)
    }

}
