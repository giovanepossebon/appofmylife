//
//  CollectionService.swift
//  AppOfMyLife
//
//  Created by Giovane Possebon on 11/8/17.
//  Copyright © 2017 giovane. All rights reserved.
//

import Foundation

private struct Endpoint {
    static let showCollection = "/sync/collection/shows"   // http://docs.trakt.apiary.io/#reference/sync/get-collection/get-collection
}

struct CollectionService {
    
    static let BASE_URL = TraktAPI.URLs.baseURL
    
    static func getShowCollection(callback: @escaping (Response<[Collection]>) -> ()) {
        guard let url = URL(string: "\(BASE_URL + Endpoint.showCollection)") else {
            callback(Response<[Collection]>(data: [], result: .error(message: "Invalid URL")))
            return
        }
        
        Network.request(url, method: .get, log: false) { response in
            switch response.result {
            case .success:
                guard let data = response.result.value as? [[String:Any]] else {
                    callback(Response<[Collection]>(data: [], result: .error(message: "Invalid Serialization")))
                    return
                }
                
                let shows = data.flatMap { Collection(JSON: $0) }
                callback(Response<[Collection]>(data: shows, result: .success))
            case .failure(let error):
                callback(Response<[Collection]>(data: [], result: .error(message: error.localizedDescription)))
            }
        }
        
    }
    
    
}
