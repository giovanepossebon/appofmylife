//
//  StatsService.swift
//  AppOfMyLife
//
//  Created by Giovane Possebon on 13/8/17.
//  Copyright © 2017 giovane. All rights reserved.
//

import Foundation

private enum Endpoint {
    // http://docs.trakt.apiary.io/#reference/users/stats/get-stats
    case userStats(id: String)
    
    var url: String {
        switch self {
        case .userStats(let id):
            return TraktAPI.URLs.baseURL + "users/\(id)/stats"
        }
    }
}

struct StatsService {
    
    static func getStats(fromUser user: User, callback: @escaping (Response<Stats>) -> ()) {
        guard let id = user.ids?.slug, let url = URL(string: Endpoint.userStats(id: id).url) else {
            callback(Response<Stats>(data: nil, result: .error(message: "Invalid Url")))
            return
        }
        
        Network.request(url, method: .get) { response in
            switch response.result {
            case .success:
                guard let data = response.result.value as? [String: Any] else {
                    callback(Response<Stats>(data: nil, result: .error(message: "Invalid Serialization")))
                    return
                }
                
                callback(Response<Stats>(data: Stats(JSON: data), result: .success))
            case .failure(let error):
                callback(Response<Stats>(data: nil, result: .error(message: error.localizedDescription)))
            }
        }
    }
    
}
