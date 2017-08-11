//
//  UserCredential.swift
//  AppOfMyLife
//
//  Created by Giovane Possebon on 10/8/17.
//  Copyright © 2017 giovane. All rights reserved.
//

import Foundation
import ObjectMapper

struct Auth: Mappable {
    
    var accessToken: String?
    var refreshToken: String?
    var expiresIn: Int?
    var tokenType: String?
    var scope: String?
    var createdAt: Int?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        accessToken             <- map["access_token"]
        refreshToken            <- map["refresh_token"]
        expiresIn               <- map["expires_in"]
        tokenType               <- map["token_type"]
        scope                   <- map["scope"]
        createdAt               <- map["created_at"]
    }
    
}
