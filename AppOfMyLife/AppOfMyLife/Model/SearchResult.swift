//
//  SearchResult.swift
//  AppOfMyLife
//
//  Created by Giovane Possebon on 15/8/17.
//  Copyright © 2017 giovane. All rights reserved.
//

import ObjectMapper

struct SearchResult: Mappable {
    var type: String?
    var score: Double?
    var show: Show?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        type        <- map["type"]
        score       <- map["score"]
        show        <- map["show"]
    }
}
