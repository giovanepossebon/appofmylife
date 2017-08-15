//
//  ViewControllerTest.swift
//  AppOfMyLife
//
//  Created by Giovane Possebon on 15/8/17.
//  Copyright © 2017 giovane. All rights reserved.
//

import XCTest
@testable import AppOfMyLife

class ViewControllerTests: XCTestCase {
    
    func testCreateGalleryViewController() {
        let viewController = UIStoryboard.createViewController("Collection", vcName: ShowDetailViewController.name, vcClass: ShowDetailViewController.self)
        XCTAssert(viewController != nil)
    }
    
    func testCreateViewControllerWithFailure() {
        let viewController = UIStoryboard.createViewController("badClass", vcName: "badClass", vcClass: UILabel.self)
        XCTAssert(viewController == nil)
    }
}
