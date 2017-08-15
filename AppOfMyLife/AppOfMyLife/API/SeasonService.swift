//
//  SeasonService.swift
//  AppOfMyLife
//
//  Created by Giovane Possebon on 13/8/17.
//  Copyright © 2017 giovane. All rights reserved.
//

import Foundation

private enum Endpoint {
    case seasonsList(request: SeasonListRequest)
    
    var url: String {
        switch self {
        case .seasonsList(request: let request):
            return TraktAPI.URLs.baseURL + "shows/\(request.slug)/seasons"
        }
    }
}

struct SeasonService: SeasonApiClient {
    
    static func getSeasonsList(request: SeasonListRequest, callback: @escaping (Response<[Season]>) -> ()) {
        guard let url = URL(string: Endpoint.seasonsList(request: request).url) else {
            callback(Response<[Season]>(data: [], result: Result.error(message: "Invalid URL")))
            return
        }
        
        Network.request(url, method: .get, log: true) { response in
            switch response.result {
            case .success:
                guard let data = response.result.value as? [[String: Any]] else {
                    callback(Response<[Season]>(data: [], result: Result.error(message: "Invalid Serialization")))
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
