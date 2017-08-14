//
//  UserSettings.swift
//  AppOfMyLife
//
//  Created by Giovane Possebon on 13/8/17.
//  Copyright © 2017 giovane. All rights reserved.
//

import ObjectMapper

struct UserSettings: Mappable {
    var user: User?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        user        <- map["user"]
    }
}
