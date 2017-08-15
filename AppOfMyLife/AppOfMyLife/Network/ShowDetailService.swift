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
    case showProgress(request: ShowDetailRequest)
    case showDetail(request: ShowDetailRequest)
    case nextEpisode(request: ShowDetailRequest)
    
    var url: String {
        switch self {
        case .showProgress(request: let request):
            return TraktAPI.URLs.baseURL + "shows/\(request.showId)/progress/watched"
        case .showDetail(request: let request):
            return TraktAPI.URLs.baseURL + "shows/\(request.showId)"
        case .nextEpisode(request: let request):
            return TraktAPI.URLs.baseURL + "shows/\(request.showId)/next_episode"
        }
    }
}

struct ShowDetailService: ShowDetailApiClient {

    static func getShowDetail(request: ShowDetailRequest, callback: @escaping (Response<Show>) -> ()) {
        guard let url = URL(string: Endpoint.showDetail(request: request).url) else {
            callback(Response<Show>(data: nil, result: .error(message: "Invalid URL")))
            return
        }
        
        let params: Parameters = [
            "extended": "full"
        ]
    
        Network.request(url, method: .get, parameters: params) { response in
            switch response.result {
            case .success:
                guard let data = response.result.value as? [String: Any] else {
                    callback(Response<Show>(data: nil, result: .error(message: "Invalid Serialization")))
                    return
                }
                
                callback(Response<Show>(data: Show(JSON: data), result: .success))
            case .failure(let error):
                callback(Response<Show>(data: nil, result: .error(message: error.localizedDescription)))
            }
        }
    }
    
    static func getShowProgress(request: ShowDetailRequest, callback: @escaping (Response<ShowProgress>) -> ()) {
        guard let url = URL(string: Endpoint.showProgress(request: request).url) else {
            callback(Response<ShowProgress>(data: nil, result: .error(message: "Invalid URL")))
            return
        }
        
        Network.request(url, method: .get) { response in
            switch response.result {
            case .success:
                guard let data = response.result.value as? [String: Any] else {
                    callback(Response<ShowProgress>(data: nil, result: .error(message: "Serialization error")))
                    return
                }
                
                callback(Response<ShowProgress>(data: ShowProgress(JSON: data), result: .success))
            case .failure(let error):
                callback(Response<ShowProgress>(data: nil, result: .error(message: error.localizedDescription)))
            }
        }
    }
    
    static func getNextEpisode(request: ShowDetailRequest, callback: @escaping (Response<Episode>) -> ()) {
        guard let url = URL(string: Endpoint.nextEpisode(request: request).url) else {
            callback(Response<Episode>(data: nil, result: .error(message: "Invalid URL")))
            return
        }
        
        Network.request(url, method: .get) { response in
            switch response.result {
            case .success:
                if response.response?.statusCode == 204 {
                    callback(Response<Episode>(data: nil, result: .error(message: "Next episode not found")))
                    return
                }
                
                guard let data = response.result.value as? [String: Any] else {
                    callback(Response<Episode>(data: nil, result: .error(message: "Serialization error")))
                    return
                }
                
                callback(Response<Episode>(data: Episode(JSON: data), result: Result.success))
            case .failure(let error):
                callback(Response<Episode>(data: nil, result: .error(message: error.localizedDescription)))
            }
        }
    }
    
}
