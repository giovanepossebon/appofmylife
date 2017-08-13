//
//  History.swift
//  AppOfMyLife
//
//  Created by Giovane Possebon on 13/8/17.
//  Copyright © 2017 giovane. All rights reserved.
//

import Foundation
import ObjectMapper

struct History: Mappable {
    
    var id: Int?
    var watchedAt: String?
    var action: String?
    var type: String?
    var episode: Episode?
    var show: Show?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        id          <- map["id"]
        watchedAt   <- map["watched_at"]
        action      <- map["action"]
        type        <- map["type"]
        episode     <- map["episode"]
        show        <- map["show"]
    }
    
}
