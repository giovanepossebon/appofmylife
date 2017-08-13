//
//  Season.swift
//  AppOfMyLife
//
//  Created by Giovane Possebon on 12/8/17.
//  Copyright © 2017 giovane. All rights reserved.
//

import ObjectMapper

struct Season: Mappable {
    
    var number: Int?
    var aired: Int?
    var completed: Int?
    var episodes: [Episode]?
    var ids: ExternalID?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        number          <- map["number"]
        aired           <- map["aired"]
        completed       <- map["completed"]
        episodes        <- map["episodes"]
        ids             <- map["ids"]
    }
}
