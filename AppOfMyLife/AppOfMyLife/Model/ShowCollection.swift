//
//  Collection.swift
//  AppOfMyLife
//
//  Created by Giovane Possebon on 11/8/17.
//  Copyright © 2017 giovane. All rights reserved.
//

import Foundation
import ObjectMapper

struct ShowCollection: Mappable {
    
    var lastCollectedAt: String?
    var show: Show?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        lastCollectedAt     <- map["last_collected_at"]
        show                <- map["show"]
    }
    
}
