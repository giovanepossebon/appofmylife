//
//  Show.swift
//  AppOfMyLife
//
//  Created by Giovane Possebon on 10/8/17.
//  Copyright © 2017 giovane. All rights reserved.
//

import Foundation
import ObjectMapper

struct Show: Mappable {
    var title: String?
    var year: Int?
    var ids: ExternalID?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        title       <- map["title"]
        year        <- map["year"]
        ids         <- map["ids"]
    }
}
