//
//  SearchService.swift
//  AppOfMyLife
//
//  Created by Giovane Possebon on 15/8/17.
//  Copyright © 2017 giovane. All rights reserved.
//

import Foundation

private enum Endpoint {
    case search(query: String)
    
    var url: String {
        switch self {
        case .search(let query):
            return TraktAPI.URLs.baseURL + "search/show?query=\(query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "")"
        }
    }
}

struct SearchService: SearchApiClient {
    
    static func search(withQuery query: String, callback: @escaping (Response<[SearchResult]>) -> ()) {
        guard let url = URL(string: Endpoint.search(query: query).url) else {
            callback(Response<[SearchResult]>(data: [], result: .error(message: "Invalid URL")))
            return
        }
        
        Network.request(url, method: .get) { response in
            switch response.result {
            case .success:
                guard let data = response.result.value as? [[String: Any]] else {
                    callback(Response<[SearchResult]>(data: [], result: .error(message: "Invalid Serialization")))
                    return
                }
                
                let shows = data.flatMap { SearchResult(JSON: $0) }
                callback(Response<[SearchResult]>(data: shows, result: .success))
            case .failure(let error):
                callback(Response<[SearchResult]>(data: [], result: .error(message: error.localizedDescription)))
            }
        }
    }
    
}
