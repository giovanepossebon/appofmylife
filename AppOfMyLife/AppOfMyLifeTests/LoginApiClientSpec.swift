//
//  LoginApiClientSpec.swift
//  AppOfMyLife
//
//  Created by Giovane Possebon on 15/8/17.
//  Copyright © 2017 giovane. All rights reserved.
//

import Quick
import Nimble
import Mockingjay
@testable import AppOfMyLife

class LoginApiClientSpec: QuickSpec {

    override func spec() {
        describe("login") {
            var returnedAuth: Auth?
            let urlString = TraktAPI.URLs.baseURL + "/oauth/token"
            let request = LoginRequest(code: "fd0847dbb559752d932dd3c1ac34ff98d27b11fe2fea5a864f44740cd7919ad0",
                                       clientId: "9b36d8c0db59eff5038aea7a417d73e69aea75b41aac771816d2ef1b3109cc2f",
                                       clientSecret: "d6ea27703957b69939b8104ed4524595e210cd2e79af587744a7eb6e58f5b3d2",
                                       redirectUri: "urn:ietf:wg:oauth:2.0:oob",
                                       grantType: "authorization_code")
            
            context("success") {
                
                beforeEach {
                    let _ = self.stub(urlString: urlString, jsonFileName: "GetTokenSuccess")
                    
                    LoginService.getToken(request: request, callback: { response in
                        returnedAuth = response.data
                    })
                }
                
                it("return auth") {
                    expect(returnedAuth).toEventuallyNot(beNil())
                    expect(returnedAuth?.accessToken) == "dbaf9757982a9e738f05d249b7b5b4a266b3a139049317c4909f2f263572c781"
                    expect(returnedAuth?.createdAt) == 1487889741
                    expect(returnedAuth?.tokenType) == "bearer"
                }
            }
            
        }
    }
    
}
