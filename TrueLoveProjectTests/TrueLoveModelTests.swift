//
//  TrueLoveModelTests.swift
//  TrueLoveModelTests
//
//  Created by Bomi on 2020/5/17.
//  Copyright © 2020 PrototypeC. All rights reserved.
//

import XCTest

@testable import TrueLoveProject

class TrueLoveProjectTests: XCTestCase {

    var sutM: Mask?
    var sutC: Coordinates?
    
    override func setUp() {
        sutM = Mask()
        sutC = Coordinates()
    }

    override func tearDown() {
        sutM = nil
        sutC = nil
        super.tearDown()
    }

    func testMaskModel_whenInitialized() {
        XCTAssertNotNil(sutM)
    }
    
    func testCoordinatesModel_whenInitialized() {
        XCTAssertNotNil(sutC)
    }

}
