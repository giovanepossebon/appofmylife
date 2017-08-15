//
//  EpisodeApiClientSpec.swift
//  AppOfMyLife
//
//  Created by Giovane Possebon on 14/8/17.
//  Copyright © 2017 giovane. All rights reserved.
//

import Quick
import Nimble
import Mockingjay
@testable import AppOfMyLife

class EpisodeApiClientSpec: QuickSpec {
    
    override func spec() {
        describe("getEpisodeDetail") {
            var returnedEpisode: Episode?
            let urlString = TraktAPI.URLs.baseURL + "shows/game-of-thrones/seasons/1/episodes/1"
            let request = EpisodeDetailRequest(slug: "game-of-thrones", seasonNumber: 1, episodeNumber: 1)
            
            context("success") {
                
                beforeEach {
                    let _ = self.stub(urlString: urlString, jsonFileName: "GetEpisodeDetailSuccess")
                    
                    EpisodeService.getEpisodeDetail(request: request, callback: { response in
                        returnedEpisode = response.data
                    })
                }
                
                it("return episode") {
                    expect(returnedEpisode).toEventuallyNot(beNil())
                    expect(returnedEpisode?.title) == "Winter Is Coming"
                    expect(returnedEpisode?.season) == 1
                    expect(returnedEpisode?.number) == 1
                    expect(returnedEpisode?.fullEpisodeName()) == "S1E1 Winter Is Coming"
                    expect(returnedEpisode?.numberedEpisodeName()) == "1 - Winter Is Coming"
                }
            }
        }
        
        describe("getEpisodeList") {
            var returnedEpisodeList: [Episode]?
            let urlString = TraktAPI.URLs.baseURL + "shows/vikings/seasons/0/episodes"
            let request = EpisodeListRequest(slug: "vikings", seasonNumber: 0)
            
            context("success") {
                
                beforeEach {
                    let _ = self.stub(urlString: urlString, jsonFileName: "GetEpisodeListSuccess")
                    
                    EpisodeService.getEpisodeList(request: request, callback: { response in
                        returnedEpisodeList = response.data
                    })
                }
                
                it("return episode list") {
                    expect(returnedEpisodeList).toEventuallyNot(beNil())
                    expect(returnedEpisodeList?.first?.title) == "First Look: Behind the Scenes"
                    expect(returnedEpisodeList?.first?.season) == 0
                    expect(returnedEpisodeList?.first?.number) == 1
                }
                
            }
        }
    }
    
}
