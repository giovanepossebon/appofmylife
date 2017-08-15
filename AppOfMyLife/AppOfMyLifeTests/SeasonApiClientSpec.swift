//
//  SeasonApiClientSpec.swift
//  AppOfMyLife
//
//  Created by Giovane Possebon on 14/8/17.
//  Copyright © 2017 giovane. All rights reserved.
//

import Quick
import Nimble
import Mockingjay
@testable import AppOfMyLife

class SeasonApiClientSpec: QuickSpec {
    
    override func spec() {
        describe("getSeasonList") {
            var returnSeasonList: [Season]?
            let urlString = TraktAPI.URLs.baseURL + "shows/game-of-thrones/seasons"
            let request = SeasonListRequest(slug: "game-of-thrones")
            
            context("success") {
                
                beforeEach {
                    let _ = self.stub(urlString: urlString, jsonFileName: "GetSeasonListSuccess")
                    
                    SeasonService.getSeasonsList(request: request, callback: { response in
                        returnSeasonList = response.data
                    })
                }
                
                it("return season list") {
                    expect(returnSeasonList).toEventuallyNot(beNil())
                    expect(returnSeasonList?.first?.number) == 0
                    expect(returnSeasonList?.first?.ids?.tvdb) == 137481
                    expect(returnSeasonList?.first?.ids?.tvrage).to(beNil())
                }
            }
            
        }
    }
    
}
