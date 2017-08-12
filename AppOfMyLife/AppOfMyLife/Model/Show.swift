//
//  Show.swift
//  AppOfMyLife
//
//  Created by Giovane Possebon on 10/8/17.
//  Copyright © 2017 giovane. All rights reserved.
//

import Foundation
import ObjectMapper

enum ShowBannerStyle {
    case landscape(id: Int)
    case portrait(id: Int)
    
    var url: String {
        switch self {
        case .landscape(id: let id):
            return "https://thetvdb.com/banners/graphical/\(id)-g2.jpg"
        case .portrait(id: let id):
            return "https://thetvdb.com/banners/posters/\(id)-1.jpg"
        }
    }
}

struct Show: Mappable {
    var title: String?
    var year: Int?
    var ids: ExternalID?
    var overview: String?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        title       <- map["title"]
        year        <- map["year"]
        ids         <- map["ids"]
        overview    <- map["overview"]
    }
    
    func getThumbnailImage(forBannerStyle style: ShowBannerStyle) -> String {
        return style.url
    }
}
