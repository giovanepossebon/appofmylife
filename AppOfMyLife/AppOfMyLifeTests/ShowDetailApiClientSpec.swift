//
//  ShowDetailApiClientSpec.swift
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

class ShowDetailApiClientSpec: QuickSpec {
    
    override func spec() {
        describe("getShowProgress") {
            var returnedProgress: ShowProgress?
            let urlString = TraktAPI.URLs.baseURL + "shows/game-of-thrones/progress/watched"
            let request = ShowDetailRequest(showId: "game-of-thrones")
            
            context("success") {
                
                beforeEach {
                    let _ = self.stub(urlString: urlString, jsonFileName: "GetShowProgressSuccess")
                    
                    ShowDetailService.getShowProgress(request: request, callback: { response in
                        returnedProgress = response.data
                    })
                }
                
                it("return schedule") {
                    expect(returnedProgress).toEventuallyNot(beNil())
                    expect(returnedProgress?.aired) == 8
                    expect(returnedProgress?.completed) == 6
                }
            }
            
        }
        
        describe("getShowDetail") {
            var returnedProgress: Show?
            let urlString = TraktAPI.URLs.baseURL + "shows/game-of-thrones"
            let request = ShowDetailRequest(showId: "game-of-thrones")
        
            context("success") {
            
                beforeEach {
                    let _ = self.stub(urlString: urlString, jsonFileName: "GetShowDetailSuccess")
                    
                    ShowDetailService.getShowDetail(request: request, callback: { response in
                        returnedProgress = response.data
                    })
                }
                
                it("return show detail") {
                    expect(returnedProgress).toEventuallyNot(beNil())
                    expect(returnedProgress?.title) == "Game of Thrones"
                    expect(returnedProgress?.year) == 2011
                    expect(returnedProgress?.ids?.slug) == "game-of-thrones"
                    expect(returnedProgress?.ids?.imdb) == "tt0944947"
                }
            
            }
        }
        
        describe("getNextEpisode") {
            var returnedEpisode: Episode?
            let urlString = TraktAPI.URLs.baseURL + "shows/game-of-thrones/next_episode"
            let request = ShowDetailRequest(showId: "game-of-thrones")
            
            context("success") {
                
                beforeEach {
                    let _ = self.stub(urlString: urlString, jsonFileName: "GetNextEpisodeSuccess")
                    
                    ShowDetailService.getNextEpisode(request: request, callback: { response in
                        returnedEpisode = response.data
                    })
                }
                
                it("return next episode") {
                    expect(returnedEpisode).toEventuallyNot(beNil())
                    expect(returnedEpisode?.number) == 1
                    expect(returnedEpisode?.season) == 7
                    expect(returnedEpisode?.ids?.tvdb) == 5773656
                    expect(returnedEpisode?.title) == "TBA"
                }
                
            }
        }
    }
}
