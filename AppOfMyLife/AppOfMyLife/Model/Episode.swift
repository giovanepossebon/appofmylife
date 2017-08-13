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
    var completed: Bool?
    var overview: String?
    var firstAired: String?
    var runtime: Int?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        season          <- map["season"]
        number          <- map["number"]
        title           <- map["title"]
        ids             <- map["ids"]
        completed       <- map["completed"]
        overview        <- map["overview"]
        firstAired      <- map["first_aired"]
        runtime         <- map["runtime"]
    }
    
    func fullEpisodeName() -> String {
        if let season = self.season, let episode = self.number {
            return "S\(season)E\(episode) \(title ?? "")"
        }
        
        return title ?? ""
    }
    
    func numberedEpisodeName() -> String {
        if let episode = self.number {
            return "\(episode) - \(title ?? "")"
        }
        
        return title ?? ""
    }
    
    func getThumbnailImage(forBannerStyle style: ShowBannerStyle) -> String {
        return style.url
    }
}


