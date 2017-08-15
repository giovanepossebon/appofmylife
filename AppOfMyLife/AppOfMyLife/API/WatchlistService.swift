//
//  WatchlistService.swift
//  AppOfMyLife
//
//  Created by Giovane Possebon on 15/8/17.
//  Copyright © 2017 giovane. All rights reserved.
//

import Foundation

private enum Endpoint {
    case addToWatchlist
    
    var url: String {
        switch self {
        case .addToWatchlist:
            return TraktAPI.URLs.baseURL + "sync/watchlist"
        }
    }
}

struct WatchlistService: WatchlistApiClient {
    
    static func syncWatchlist(withShow show: Show, callback: @escaping (Response<WatchlistSync>) -> ()) {
        guard let url = URL(string: Endpoint.addToWatchlist.url) else {
            callback(Response<WatchlistSync>(data: nil, result: .error(message: "Invalid URL")))
            return
        }
        
        let parameters: [String: Any] = [
            "shows": [
                show.toJSON()
            ]
        ]
        
        Network.request(url, method: .post, parameters: parameters) { response in
            switch response.result {
            case .success:
                guard response.response?.statusCode == 201, let data = response.result.value as? [String: Any] else {
                    callback(Response<WatchlistSync>(data: nil, result: .error(message: "Invalid response")))
                    return
                }
                
                callback(Response<WatchlistSync>(data: WatchlistSync(JSON: data), result: .success))
            case .failure(let error):
                callback(Response<WatchlistSync>(data: nil, result: .error(message: error.localizedDescription)))
            }
        }
    }
    
}
