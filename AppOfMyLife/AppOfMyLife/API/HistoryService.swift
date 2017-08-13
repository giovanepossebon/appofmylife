//
//  HistoryService.swift
//  AppOfMyLife
//
//  Created by Giovane Possebon on 13/8/17.
//  Copyright © 2017 giovane. All rights reserved.
//

import Foundation
import Alamofire

private enum Endpoint {
    // http://docs.trakt.apiary.io/#reference/sync/get-history/get-watched-history
    case getHistory(id: Int)
    // http://docs.trakt.apiary.io/#reference/sync/add-to-history/add-items-to-watched-history
    case addToHistory
    
    var url: String {
        switch self {
        case .getHistory(id: let id):
            return TraktAPI.URLs.baseURL + "sync/history/episodes/\(id)"
        case .addToHistory:
            return TraktAPI.URLs.baseURL + "sync/history"
        }
    }
}

struct HistoryService {
    
    static func getEpisodeHistory(episode: Episode, callback: @escaping (Response<[History]>) -> ()) {
        guard let id = episode.ids?.trakt, let url = URL(string: Endpoint.getHistory(id: id).url) else {
            callback(Response<[History]>(data: nil, result: .error(message: "Invalid URL")))
            return
        }
        
        Network.request(url, method: .get) { response in
            switch response.result {
            case .success:
                guard let data = response.result.value as? [[String: Any]] else {
                    callback(Response<[History]>(data: nil, result: .error(message: "Serialization failed")))
                    return
                }
                
                let history = data.flatMap { History(JSON: $0) }
                callback(Response<[History]>(data: history, result: .success))
            case .failure(let error):
                callback(Response<[History]>(data: nil, result: .error(message: error.localizedDescription)))
            }
        }
    }
    
    static func syncHistory(withEpisode episode: Episode, callback: @escaping (Response<Result>) -> ()) {
        guard let ids = episode.ids, let url = URL(string: Endpoint.addToHistory.url) else {
            callback(Response<Result>(data: nil, result: .error(message: "Invalid URL")))
            return
        }
        
        let parameters: [String: Any] = [
            "episodes": [
                ["watched_at": "release",
                 "ids": ids.toJSON()]
            ]
        ]
        
        Network.request(url, method: .post, parameters: parameters, encoding: URLEncoding.queryString) { response in
            switch response.result {
            case .success:
                guard response.response?.statusCode == 201 else {
                    callback(Response<Result>(data: nil, result: .error(message: "Problem")))
                    return
                }
                
                callback(Response<Result>(data: nil, result: .success))
            case .failure(let error):
                callback(Response<Result>(data: nil, result: .error(message: error.localizedDescription)))
            }
        }
    }
}
