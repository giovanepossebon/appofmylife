//
//  Stats.swift
//  AppOfMyLife
//
//  Created by Giovane Possebon on 13/8/17.
//  Copyright © 2017 giovane. All rights reserved.
//

import ObjectMapper

struct Stats: Mappable {
    var show: ShowStats?
    var episode: EpisodeStats?
    var network: SocialStats?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        show        <- map["shows"]
        episode     <- map["episodes"]
        network     <- map["network"]
    }
}

struct ShowStats: Mappable {
    var watched: Int = 0
    var collected: Int = 0
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        watched         <- map["watched"]
        collected       <- map["collected"]
    }
}

struct EpisodeStats: Mappable {
    var plays: Int = 0
    var watched: Int = 0
    var minutes: Int = 0
    var collected: Int = 0
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        plays           <- map["plays"]
        watched         <- map["watched"]
        minutes         <- map["minutes"]
        collected       <- map["collected"]
    }
}

struct SocialStats: Mappable {
    var friends: Int = 0
    var followers: Int = 0
    var following: Int = 0
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        friends         <- map["friends"]
        followers       <- map["followers"]
        following       <- map["following"]
    }
}
