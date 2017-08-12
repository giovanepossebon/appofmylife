//
//  ExternalID.swift
//  AppOfMyLife
//
//  Created by Giovane Possebon on 10/8/17.
//  Copyright © 2017 giovane. All rights reserved.
//

import Foundation
import ObjectMapper

enum ExternalService: String {
    case tvdb = "tvdb"
}

struct ExternalID: Mappable {
    var trakt: Int?
    var slug: String?
    var tvdb: Int?
    var imdb: String?
    var tmbd: Int?
    var tvrage: Int?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        trakt       <- map["trakt"]
        slug        <- map["slug"]
        tvdb        <- map["tvdb"]
        imdb        <- map["imdb"]
        tmbd        <- map["tmdb"]
        tvrage      <- map["tvrage"]
    }
}
