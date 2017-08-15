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
    case getHistory(request: HistoryRequest)
    case addToHistory
    
    var url: String {
        switch self {
        case .getHistory(request: let request):
            return TraktAPI.URLs.baseURL + "sync/history/episodes/\(request.traktId)"
        case .addToHistory:
            return TraktAPI.URLs.baseURL + "sync/history"
        }
    }
}

struct HistoryService: HistoryApiClient {
    
    static func getEpisodeHistory(request: HistoryRequest, callback: @escaping (Response<[History]>) -> ()) {
        guard let url = URL(string: Endpoint.getHistory(request: request).url) else {
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
        
        Network.request(url, method: .post, parameters: parameters) { response in
            switch response.result {
            case .success:
                guard response.response?.statusCode == 201 else {
                    callback(Response<Result>(data: nil, result: .error(message: "Invalid response")))
                    return
                }
                
                callback(Response<Result>(data: nil, result: .success))
            case .failure(let error):
                callback(Response<Result>(data: nil, result: .error(message: error.localizedDescription)))
            }
        }
    }
}
