//
//  XCTest+Extensions.swift
//  AppOfMyLife
//
//  Created by Giovane Possebon on 14/8/17.
//  Copyright © 2017 giovane. All rights reserved.
//

import XCTest
import Mockingjay

extension XCTest {
    public func stub(urlString: String, jsonFileName: String) -> Mockingjay.Stub {
        let path = Bundle(for: type(of: self)).path(forResource: jsonFileName, ofType: "json")!
        let data = try! Data(contentsOf: URL(fileURLWithPath: path))
        return stub(uri(urlString), jsonData(data))
    }
    
    public func stub(urlString: String, error: NSError) -> Mockingjay.Stub {
        return stub(uri(urlString), failure(error))
    }
}
