//
//  LoginService.swift
//  AppOfMyLife
//
//  Created by Giovane Possebon on 9/8/17.
//  Copyright © 2017 giovane. All rights reserved.
//

import Foundation
import Alamofire

struct LoginService: LoginApiClient {
    
    static let BASE_URL = TraktAPI.URLs.baseURL
    
    static func getToken(request: LoginRequest, callback: @escaping (Response<Auth>) -> ()) {
        let params = [
            "code": request.code,
            "client_id": request.clientId,
            "client_secret": request.clientSecret,
            "redirect_uri": request.redirectUri,
            "grant_type": request.grantType
        ]
        
        guard let url = URL(string: "\(BASE_URL)/oauth/token") else {
            callback(Response<Auth>(data: nil, result: Result.error(message: "Invalid URL")))
            return
        }
        
        Network.request(url, method: .post, parameters: params) { response in
            switch response.result {
            case .success:
                guard let data = response.result.value as? [String: Any] else {
                    callback(Response<Auth>(data: nil, result: Result.error(message: "Invalid Serialization")))
                    return
                }
                
                callback(Response<Auth>(data: Auth(JSON: data), result: Result.success))
            case .failure(let error):
                callback(Response<Auth>(data: nil, result: Result.error(message: error.localizedDescription)))
            }
        }
    }
    
}
