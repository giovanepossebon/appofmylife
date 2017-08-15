//
//  CollectionApiClientSpec.swift
//  AppOfMyLife
//
//  Created by Giovane Possebon on 14/8/17.
//  Copyright © 2017 giovane. All rights reserved.
//

import Foundation

import Quick
import Nimble
import Mockingjay
@testable import AppOfMyLife

class CollectionApiClientSpec: QuickSpec {
    
    override func spec() {
        describe("getMyCollection") {
            var returnedShowCollection: [ShowCollection]?
            let urlString = TraktAPI.URLs.baseURL + "sync/collection/shows"
            
            context("success") {
                
                beforeEach {
                    let _ = self.stub(urlString: urlString, jsonFileName: "GetCollectionSuccess")
                    
                    CollectionService.getShowCollection(callback: { response in
                        returnedShowCollection = response.data
                    })
                }
                
                it("return schedule") {
                    expect(returnedShowCollection).toEventuallyNot(beNil())
                    expect(returnedShowCollection?.first?.show?.title) == "Rick and Morty"
                    expect(returnedShowCollection?.first?.show?.year) == 2013
                }
            }
            
        }
    }
    
}
