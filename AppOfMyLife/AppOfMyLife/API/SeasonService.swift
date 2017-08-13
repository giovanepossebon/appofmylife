//
//  SeasonService.swift
//  AppOfMyLife
//
//  Created by Giovane Possebon on 13/8/17.
//  Copyright © 2017 giovane. All rights reserved.
//

import Foundation

private enum Endpoint {
    // http://docs.trakt.apiary.io/#reference/seasons/summary/get-all-seasons-for-a-show
    case seasonsList(id: String)
    
    var url: String {
        switch self {
        case .seasonsList(id: let id):
            return TraktAPI.URLs.baseURL + "shows/\(id)/seasons"
        }
    }
}

struct SeasonService {
    
    static func getSeasonsList(fromShow show: Show, callback: @escaping (Response<[Season]>) -> ()) {
        guard let slug = show.ids?.slug, let url = URL(string: Endpoint.seasonsList(id: slug).url) else {
            callback(Response<[Season]>(data: [], result: Result.error(message: "Invalid URL")))
            return
        }
        
        Network.request(url, method: .get, log: true) { response in
            switch response.result {
            case .success:
                guard let data = response.result.value as? [[String: Any]] else {
                    callback(Response<[Season]>(data: [], result: Result.error(message: "Serialization Error")))
                    return
                }
                
                let seasons = data.flatMap { Season(JSON: $0) }
                callback(Response<[Season]>(data: seasons, result: Result.success))
            case .failure(let error):
                callback(Response<[Season]>(data: [], result: Result.error(message: error.localizedDescription)))
            }
        }
    }
    
}
