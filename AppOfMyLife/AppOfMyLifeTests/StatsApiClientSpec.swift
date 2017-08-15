//
//  StatsApiClientSpec.swift
//  AppOfMyLife
//
//  Created by Giovane Possebon on 14/8/17.
//  Copyright © 2017 giovane. All rights reserved.
//

import Quick
import Nimble
import Mockingjay
@testable import AppOfMyLife

class StatsApiClientSpec: QuickSpec {
    
    override func spec() {
        describe("getUserStats") {
            var returnedStats: Stats?
            let urlString = TraktAPI.URLs.baseURL + "users/sean/stats"
            let request = StatsRequest(slug: "sean")
            
            context("success") {
                
                beforeEach {
                    let _ = self.stub(urlString: urlString, jsonFileName: "GetStatsSuccess")
                    
                    StatsService.getStats(request: request, callback: { response in
                        returnedStats = response.data
                    })
                }
                
                it("return stats settings") {
                    expect(returnedStats).toEventuallyNot(beNil())
                    expect(returnedStats?.episode?.minutes) == 17330
                    expect(returnedStats?.show?.watched) == 16
                    expect(returnedStats?.network?.followers) == 4
                }
            }
            
        }
    }
    
}
