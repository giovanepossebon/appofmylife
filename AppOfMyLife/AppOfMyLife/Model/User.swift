//
//  User.swift
//  AppOfMyLife
//
//  Created by Giovane Possebon on 13/8/17.
//  Copyright © 2017 giovane. All rights reserved.
//

import ObjectMapper

struct User: Mappable {
    var username: String?
    var name: String?
    var ids: ExternalID?
    var location: String?
    var about: String?
    var gender: String?
    var age: Int?
    var avatar: String?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        username        <- map["username"]
        name            <- map["name"]
        ids             <- map["ids"]
        location        <- map["location"]
        about           <- map["about"]
        gender          <- map["gender"]
        age             <- map["age"]
        avatar          <- map["images.avatar.full"]
    }
}
