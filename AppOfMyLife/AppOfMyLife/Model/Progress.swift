//
//  Progress.swift
//  AppOfMyLife
//
//  Created by Giovane Possebon on 12/8/17.
//  Copyright © 2017 giovane. All rights reserved.
//

import ObjectMapper

struct Progress: Mappable {
    
    var aired: Int?
    var completed: Int?
    var lastCollectedAt: String?
    var nextEpisode: Episode?
 
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        aired               <- map["aired"]
        completed           <- map["completed"]
        lastCollectedAt     <- map["last_collected_at"]
        nextEpisode         <- map["next_episode"]
    }
}
