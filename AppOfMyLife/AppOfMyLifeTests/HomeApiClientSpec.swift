//
//  HomeApiClientSpec.swift
//  AppOfMyLife
//
//  Created by Giovane Possebon on 14/8/17.
//  Copyright © 2017 giovane. All rights reserved.
//

import Quick
import Nimble
import Mockingjay
@testable import AppOfMyLife

class HomeApiClientSpec: QuickSpec {
    
    override func spec() {
        describe("getMySchedule") {
            var returnedSchedule: [Schedule]?
            let urlString = TraktAPI.URLs.baseURL + "calendars/my/shows/2014-08-06/7"
            let request = HomeServiceRequest(startDate: "2014-08-06", days: 7)
            
            context("success") {
                
                beforeEach {
                    let _ = self.stub(urlString: urlString, jsonFileName: "GetCalendarSuccess")
                    
                    HomeService.getMySchedule(request: request, callback: { response in
                        returnedSchedule = response.data
                    })
                }
                
                it("return schedule") {
                    expect(returnedSchedule).toEventuallyNot(beNil())
                    expect(returnedSchedule?.first?.episode?.season) == 7
                    expect(returnedSchedule?.first?.episode?.number) == 4
                    expect(returnedSchedule?.first?.episode?.title) == "Death is Not the End"
                    expect(returnedSchedule?.first?.show?.title) == "True Blood"
                    expect(returnedSchedule?.first?.show?.year) == 2008
                }
            }
            
        }
    }
    
}


