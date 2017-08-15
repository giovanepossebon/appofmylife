//
//  LoginApiClient.swift
//  AppOfMyLife
//
//  Created by Giovane Possebon on 14/8/17.
//  Copyright © 2017 giovane. All rights reserved.
//

import Foundation

protocol LoginApiClient {
    //http://docs.trakt.apiary.io/#reference/authentication-oauth/get-token/exchange-code-for-access_token
    static func getToken(request: LoginRequest, callback: @escaping (Response<Auth>) -> ())
}
