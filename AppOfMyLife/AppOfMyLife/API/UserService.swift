//
//  ProfileService.swift
//  AppOfMyLife
//
//  Created by Giovane Possebon on 13/8/17.
//  Copyright © 2017 giovane. All rights reserved.
//

import Foundation
import Alamofire

private enum Endpoint {
    case userSettings
    
    var url: String {
        switch self {
        case .userSettings:
            return TraktAPI.URLs.baseURL + "users/settings"
        }
    }
}

struct UserService: UserApiClient {
    
    static func getUserSettings(callback: @escaping (Response<UserSettings>) -> ()) {
        guard let url = URL(string: Endpoint.userSettings.url) else {
            callback(Response<UserSettings>(data: nil, result: Result.error(message: "Invalid URL")))
            return
        }
        
        Network.request(url, method: .get) { response in
            switch response.result {
            case .success:
                guard let data = response.result.value as? [String: Any] else {
                    callback(Response<UserSettings>(data: nil, result: Result.error(message: "Invalid Serialization")))
                    return
                }
                
                callback(Response<UserSettings>(data: UserSettings(JSON: data), result: Result.success))
            case .failure(let error):
                callback(Response<UserSettings>(data: nil, result: Result.error(message: error.localizedDescription)))
            }
        }
    }
    
}
