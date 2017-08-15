//
//  WatchlistSync.swift
//  AppOfMyLife
//
//  Created by Giovane Possebon on 15/8/17.
//  Copyright © 2017 giovane. All rights reserved.
//

import ObjectMapper

struct WatchlistSync: Mappable {
    var added: SyncList?
    var existing: SyncList?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        added           <- map["added"]
        existing        <- map["existing"]
    }
}

struct SyncList: Mappable {
    var episodes: Int = 0
    var movies: Int = 0
    var seasons: Int = 0
    var shows: Int = 0
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        episodes        <- map["episodes"]
        movies          <- map["movies"]
        seasons         <- map["seasons"]
        shows           <- map["shows"]
    }
}
