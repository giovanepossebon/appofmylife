//
//  LoginService.swift
//  AppOfMyLife
//
//  Created by Giovane Possebon on 9/8/17.
//  Copyright © 2017 giovane. All rights reserved.
//

import Foundation
import Alamofire

struct LoginService {
    
    static let BASE_URL = TraktAPI.URLs.baseURL
    
    static func getToken(code: String, callback: @escaping (Response<Auth>) -> ()) {
        let params = [
            "code": code,
            "client_id": TraktAPI.clientId,
            "client_secret": TraktAPI.clientSecret,
            "redirect_uri": TraktAPI.redirectUri,
            "grant_type": "authorization_code"
        ]
        
        guard let url = URL(string: "\(BASE_URL)/oauth/token") else {
            callback(Response<Auth>(data: nil, result: Result.error(message: "URL invalida")))
            return
        }
        
        Network.request(url, method: .post, parameters: params) { response in
            switch response.result {
            case .success:
                guard let data = response.result.value as? [String: Any] else {
                    callback(Response<Auth>(data: nil, result: Result.error(message: "Erro ao parsear")))
                    return
                }
                
                callback(Response<Auth>(data: Auth(JSON: data), result: Result.success))
            case .failure(let error):
                callback(Response<Auth>(data: nil, result: Result.error(message: error.localizedDescription)))
            }
        }
    }
    
}
