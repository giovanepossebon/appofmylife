//
//  StatsService.swift
//  AppOfMyLife
//
//  Created by Giovane Possebon on 13/8/17.
//  Copyright © 2017 giovane. All rights reserved.
//

import Foundation

private enum Endpoint {
    case userStats(request: StatsRequest)
    
    var url: String {
        switch self {
        case .userStats(let request):
            return TraktAPI.URLs.baseURL + "users/\(request.slug)/stats"
        }
    }
}

struct StatsService: StatsApiClient {
    
    static func getStats(request: StatsRequest, callback: @escaping (Response<Stats>) -> ()) {
        guard let url = URL(string: Endpoint.userStats(request: request).url) else {
            callback(Response<Stats>(data: nil, result: .error(message: "Invalid URL")))
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
