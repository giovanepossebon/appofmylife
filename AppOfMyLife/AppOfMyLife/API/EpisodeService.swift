//
//  EpisodeService.swift
//  AppOfMyLife
//
//  Created by Giovane Possebon on 12/8/17.
//  Copyright © 2017 giovane. All rights reserved.
//

import Foundation
import Alamofire

private enum Endpoint {
    case episodeDetail(request: EpisodeDetailRequest)
    case episodesList(request: EpisodeListRequest)
    
    var url: String {
        switch self {
        case .episodeDetail(request: let request):
            return TraktAPI.URLs.baseURL + "shows/\(request.slug)/seasons/\(request.seasonNumber)/episodes/\(request.episodeNumber)"
        case .episodesList(request: let request):
            return TraktAPI.URLs.baseURL + "shows/\(request.slug)/seasons/\(request.seasonNumber)/episodes"
        }
    }
}

struct EpisodeService: EpisodeApiClient {
    
    static func getEpisodeList(request: EpisodeListRequest, callback: @escaping (Response<[Episode]>) -> ()) {
        guard let url = URL(string: Endpoint.episodesList(request: request).url) else {
            callback(Response<[Episode]>(data: [], result: .error(message: "Invalid URL")))
            return
        }
        
        Network.request(url, method: .get) { response in
            switch response.result {
            case .success:
                guard let data = response.result.value as? [[String: Any]] else {
                    callback(Response<[Episode]>(data: [], result: .error(message: "Serialization failed")))
                    return
                }
                
                let episodes = data.flatMap { Episode(JSON: $0) }
                callback(Response<[Episode]>(data: episodes, result: Result.success))
            case .failure(let error):
                callback(Response<[Episode]>(data: [], result: .error(message: error.localizedDescription)))
            }
        }
    }
    
    static func getEpisodeDetail(request: EpisodeDetailRequest, callback: @escaping (Response<Episode>) -> ()) {
        guard let url = URL(string: Endpoint.episodeDetail(request: request).url) else {
            callback(Response<Episode>(data: nil, result: .error(message: "Invalid URL")))
            return
        }
        
        let parameters: Parameters = ["extended": "full"]
        
        Network.request(url, method: .get, parameters: parameters) { response in
            switch response.result {
            case .success:
                guard let data = response.result.value as? [String:Any] else {
                    callback(Response<Episode>(data: nil, result: .error(message: "Erro ao parsear")))
                    return
                }
                
                callback(Response<Episode>(data: Episode(JSON: data), result: Result.success))
            case .failure(let error):
                callback(Response<Episode>(data: nil, result: .error(message: error.localizedDescription)))
            }
        }
        
        
    }
    
}
