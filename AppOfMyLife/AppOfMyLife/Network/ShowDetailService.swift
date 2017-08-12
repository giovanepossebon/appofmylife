//
//  ShowDetailService.swift
//  AppOfMyLife
//
//  Created by Giovane Possebon on 12/8/17.
//  Copyright © 2017 giovane. All rights reserved.
//

import Foundation
import Alamofire

private enum Endpoint {
    // http://docs.trakt.apiary.io/#reference/shows/collection-progress/get-show-watched-progress
    case showProgress(showId: String)
    // http://docs.trakt.apiary.io/#reference/shows/summary/get-a-single-show
    case showDetail(showId: String)
    // http://docs.trakt.apiary.io/#reference/shows/next-episode/get-next-episode
    case nextEpisode(showId: String)
    
    var url: String {
        switch self {
        case .showProgress(showId: let id):
            return TraktAPI.URLs.baseURL + "shows/\(id)/progress/watched"
        case .showDetail(showId: let id):
            return TraktAPI.URLs.baseURL + "shows/\(id)"
        case .nextEpisode(showId: let id):
            return TraktAPI.URLs.baseURL + "shows/\(id)/next_episode"
        }
    }
}

struct ShowDetailService {

    static func getShowDetail(forShow show: Show, callback: @escaping (Response<Show>) -> ()) {
        guard let slug = show.ids?.slug else {
            callback(Response<Show>(data: nil, result: Result.error(message: "Slug not found")))
            return
        }
        
        guard let url = URL(string: Endpoint.showDetail(showId: slug).url) else {
            callback(Response<Show>(data: nil, result: Result.error(message: "URL invalida")))
            return
        }
        
        let params: Parameters = [
            "extended": "full"
        ]
    
        Network.request(url, method: .get, parameters: params, log: true) { response in
            switch response.result {
            case .success:
                guard let data = response.result.value as? [String:Any] else {
                    callback(Response<Show>(data: nil, result: Result.error(message: "Erro ao parsear")))
                    return
                }
                
                callback(Response<Show>(data: Show(JSON: data), result: Result.success))
            case .failure(let error):
                callback(Response<Show>(data: nil, result: Result.error(message: error.localizedDescription)))
            }
        }
    }
    
    static func getShowProgress(forShow show: Show, callback: @escaping (Response<Progress>) -> ()) {
        guard let slug = show.ids?.slug else {
            callback(Response<Progress>(data: nil, result: Result.error(message: "Slug not found")))
            return
        }
        
        guard let url = URL(string: Endpoint.showProgress(showId: slug).url) else {
            callback(Response<Progress>(data: nil, result: Result.error(message: "Invalid URL")))
            return
        }
        
        Network.request(url, method: .get, log: true) { response in
            switch response.result {
            case .success:
                guard let data = response.result.value as? [String: Any] else {
                    callback(Response<Progress>(data: nil, result: Result.error(message: "Serialization error")))
                    return
                }
                
                callback(Response<Progress>(data: Progress(JSON: data), result: Result.success))
            case .failure(let error):
                callback(Response<Progress>(data: nil, result: Result.error(message: error.localizedDescription)))
            }
        }
    }
    
    static func getNextEpisode(forShow show: Show, callback: @escaping (Response<Episode>) -> ()) {
        guard let slug = show.ids?.slug else {
            callback(Response<Episode>(data: nil, result: Result.error(message: "Slug not found")))
            return
        }
        
        guard let url = URL(string: Endpoint.nextEpisode(showId: slug).url) else {
            callback(Response<Episode>(data: nil, result: Result.error(message: "Invalid URL")))
            return
        }
        
        Network.request(url, method: .get, log: true) { response in
            switch response.result {
            case .success:
                if response.response?.statusCode == 204 {
                    callback(Response<Episode>(data: nil, result: Result.error(message: "Next episode not found")))
                    return
                }
                
                guard let data = response.result.value as? [String: Any] else {
                    callback(Response<Episode>(data: nil, result: Result.error(message: "Serialization error")))
                    return
                }
                
                callback(Response<Episode>(data: Episode(JSON: data), result: Result.success))
            case .failure(let error):
                callback(Response<Episode>(data: nil, result: Result.error(message: error.localizedDescription)))
            }
        }
    }
    
}
