//
//  LoginRequest.swift
//  AppOfMyLife
//
//  Created by Giovane Possebon on 15/8/17.
//  Copyright © 2017 giovane. All rights reserved.
//

import Foundation

struct LoginRequest {
    let code: String
    let clientId: String
    let clientSecret: String
    let redirectUri: String
    let grantType: String
}
