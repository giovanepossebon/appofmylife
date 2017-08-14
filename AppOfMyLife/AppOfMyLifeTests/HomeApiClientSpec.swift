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
            context("success") {
                it("return schedule") {
                    var returnedSchedule: [Schedule]?
                    
                    let path = Bundle(for: type(of: self)).path(forResource: "GetCalendarSuccess", ofType: "json")!
                    let data = try! Data(contentsOf: URL(fileURLWithPath: path))
                    self.stub(uri("https://api.trakt.tv/calendars/my/shows"), jsonData(data))
                    
                    StatsService.getStats(fromUser: <#T##User#>, callback: <#T##(Response<Stats>) -> ()#>)
                    
                    HomeService.getMySchedule(callback: { response in
                        returnedSchedule = response.data
                    })
                    expect(returnedSchedule).toEventuallyNot(beNil())
                }
            }
            
        }
    }
    
}


