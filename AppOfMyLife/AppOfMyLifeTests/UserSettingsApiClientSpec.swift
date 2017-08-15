//
//  UserSettingsApiClientSpec.swift
//  AppOfMyLife
//
//  Created by Giovane Possebon on 14/8/17.
//  Copyright © 2017 giovane. All rights reserved.
//

import Quick
import Nimble
import Mockingjay
@testable import AppOfMyLife

class UserSettingsApiClientSpec: QuickSpec {
    
    override func spec() {
        describe("getUserSettings") {
            var returnUserSettings: UserSettings?
            let urlString = TraktAPI.URLs.baseURL + "users/settings"
            
            context("success") {
                
                beforeEach {
                    let _ = self.stub(urlString: urlString, jsonFileName: "GetUserSettingsSuccess")
                    
                    UserService.getUserSettings(callback: { response in
                        returnUserSettings = response.data
                    })
                }
                
                it("return user settings") {
                    expect(returnUserSettings).toEventuallyNot(beNil())
                    expect(returnUserSettings?.user?.name) == "Justin Nemeth"
                    expect(returnUserSettings?.user?.age) == 32
                    expect(returnUserSettings?.user?.username) == "justin"
                    expect(returnUserSettings?.user?.avatar) == "https://secure.gravatar.com/avatar/30c2f0dfbc39e48656f40498aa871e33?r=pg&s=256"
                }
            }
            
        }
    }
    
}
