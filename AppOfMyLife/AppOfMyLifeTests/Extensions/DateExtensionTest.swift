//
//  DateExtensionTest.swift
//  AppOfMyLife
//
//  Created by Giovane Possebon on 11/8/17.
//  Copyright © 2017 giovane. All rights reserved.
//

import XCTest
@testable import AppOfMyLife

class DateExtensionTest: XCTestCase {
    
    let date = Date.dateFromISOString(string: "2014-07-14T10:00:00.000Z")
    
    func testDayAndMonthDateFormat() {
        let stringDate = date.ISOStringFromDate(withDateFormat: .dayAndMonth)
        XCTAssert(stringDate == "14/07")
    }
    
    func testDayMonthAndHourDateFormat() {
        let stringDate = date.ISOStringFromDate(withDateFormat: .dayMonthAndHour)
        XCTAssert(stringDate == "14/07 - 07:00")
    }
    
    func testHourDateFormat() {
        let stringDate = date.ISOStringFromDate(withDateFormat: .hour)
        XCTAssert(stringDate == "07:00")
    }
    
    func testTraktApiDateFormat() {
        let stringDate = date.ISOStringFromDate(withDateFormat: .traktAPI)
        XCTAssert(stringDate == "2014-07-14")
    }
    
    func testYearDateFormat() {
        let stringDate = date.ISOStringFromDate(withDateFormat: .year)
        XCTAssert(stringDate == "2014")
    }
    
}
