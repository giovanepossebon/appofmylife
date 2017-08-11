//
//  Episode.swift
//  AppOfMyLife
//
//  Created by Giovane Possebon on 10/8/17.
//  Copyright © 2017 giovane. All rights reserved.
//

import Foundation
import ObjectMapper

struct Episode: Mappable {
    var season: Int?
    var number: Int?
    var title: String?
    var ids: ExternalID?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        season      <- map["season"]
        number      <- map["number"]
        title       <- map["title"]
        ids         <- map["ids"]
    }
}


