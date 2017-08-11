//
//  Schedule.swift
//  AppOfMyLife
//
//  Created by Giovane Possebon on 10/8/17.
//  Copyright © 2017 giovane. All rights reserved.
//

import ObjectMapper

struct Schedule: Mappable {
    var firstAired: String?
    var episode: Episode?
    var show: Show?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        firstAired      <- map["first_aired"]
        episode         <- map["episode"]
        show            <- map["show"]
    }
}
