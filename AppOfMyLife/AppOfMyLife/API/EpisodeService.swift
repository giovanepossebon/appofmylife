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
    // http://docs.trakt.apiary.io/#reference/episodes/summary/get-a-single-episode-for-a-show
    case episodeDetail(id: String, season: Int, episode: Int)
    case episodesList(id: String, season: Int)
    
    var url: String {
        switch self {
        case .episodeDetail(id: let id, season: let season, episode: let episode):
            return TraktAPI.URLs.baseURL + "shows/\(id)/seasons/\(season)/episodes/\(episode)"
        case .episodesList(id: let id, season: let season):
            return TraktAPI.URLs.baseURL + "shows/\(id)/seasons/\(season)/episodes"
        }
    }
}

struct EpisodeService {
    
    static func getEpisodeList(fromShow show: Show, season: Season, callback: @escaping (Response<[Episode]>) -> ()) {
        guard let slug = show.ids?.slug, let season = season.number else {
            callback(Response<[Episode]>(data: [], result: Result.error(message: "Invalid request")))
            return
        }
        
        guard let url = URL(string: Endpoint.episodesList(id: slug, season: season).url) else {
            callback(Response<[Episode]>(data: [], result: Result.error(message: "Invalid URL")))
            return
        }
        
        Network.request(url, method: .get) { response in
            switch response.result {
            case .success:
                guard let data = response.result.value as? [[String: Any]] else {
                    callback(Response<[Episode]>(data: [], result: Result.error(message: "Serialization failed")))
                    return
                }
                
                let episodes = data.flatMap { Episode(JSON: $0) }
                callback(Response<[Episode]>(data: episodes, result: Result.success))
            case .failure(let error):
                callback(Response<[Episode]>(data: [], result: Result.error(message: error.localizedDescription)))
            }
        }
    }
    
    static func getEpisodeDetail(fromShow show: Show, episode: Episode, callback: @escaping (Response<Episode>) -> ()) {
        guard let slug = show.ids?.slug, let season = episode.season, let episode = episode.number else {
            callback(Response<Episode>(data: nil, result: Result.error(message: "Invalid request")))
            return
        }
        
        guard let url = URL(string: Endpoint.episodeDetail(id: slug, season: season, episode: episode).url) else {
            callback(Response<Episode>(data: nil, result: Result.error(message: "Invalid URL")))
            return
        }
        
        let parameters: Parameters = ["extended": "full"]
        
        Network.request(url, method: .get, parameters: parameters) { response in
            switch response.result {
            case .success:
                guard let data = response.result.value as? [String:Any] else {
                    callback(Response<Episode>(data: nil, result: Result.error(message: "Erro ao parsear")))
                    return
                }
                
                callback(Response<Episode>(data: Episode(JSON: data), result: Result.success))
            case .failure(let error):
                callback(Response<Episode>(data: nil, result: Result.error(message: error.localizedDescription)))
            }
        }
        
        
    }
    
}
