//
//  CollectionService.swift
//  AppOfMyLife
//
//  Created by Giovane Possebon on 11/8/17.
//  Copyright © 2017 giovane. All rights reserved.
//

import Foundation

private struct Endpoint {
    static let showCollection = "sync/collection/shows"
}

struct CollectionService: CollectionApiClient {
    
    static let BASE_URL = TraktAPI.URLs.baseURL
    
    static func getShowCollection(callback: @escaping (Response<[ShowCollection]>) -> ()) {
        guard let url = URL(string: "\(BASE_URL + Endpoint.showCollection)") else {
            callback(Response<[ShowCollection]>(data: [], result: .error(message: "Invalid URL")))
            return
        }
        
        Network.request(url, method: .get, log: false) { response in
            switch response.result {
            case .success:
                guard let data = response.result.value as? [[String:Any]] else {
                    callback(Response<[ShowCollection]>(data: [], result: .error(message: "Invalid Serialization")))
                    return
                }
                
                let shows = data.flatMap { ShowCollection(JSON: $0) }
                callback(Response<[ShowCollection]>(data: shows, result: .success))
            case .failure(let error):
                callback(Response<[ShowCollection]>(data: [], result: .error(message: error.localizedDescription)))
            }
        }
        
    }
    
    
}
