//
//  HistoryApiClientSpec.swift
//  AppOfMyLife
//
//  Created by Giovane Possebon on 14/8/17.
//  Copyright © 2017 giovane. All rights reserved.
//

import Quick
import Nimble
import Mockingjay
@testable import AppOfMyLife

class HistoryApiClientSpec: QuickSpec {
    
    override func spec() {
        describe("getWatchedHistory") {
            var returnWatchedHistory: [History]?
            let urlString = TraktAPI.URLs.baseURL + "sync/history/episodes/73640"
            let request = HistoryRequest(traktId: 73640)
            
            context("success") {
                
                beforeEach {
                    let _ = self.stub(urlString: urlString, jsonFileName: "GetHistorySuccess")
                    
                    HistoryService.getEpisodeHistory(request: request, callback: { response in
                        returnWatchedHistory = response.data
                    })
                }
                
                it("return history list") {
                    expect(returnWatchedHistory).toEventuallyNot(beNil())
                    expect(returnWatchedHistory?.first?.id) == 3021914054
                    expect(returnWatchedHistory?.first?.action) == "watch"
                    expect(returnWatchedHistory?.first?.type) == "episode"
                    expect(returnWatchedHistory?.first?.episode?.title) == "Winter Is Coming"
                }
            }
            
        }
    }
    
}
