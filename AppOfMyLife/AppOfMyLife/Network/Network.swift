//
//  Network.swift
//  AppOfMyLife
//
//  Created by Giovane Possebon on 9/8/17.
//  Copyright © 2017 giovane. All rights reserved.
//

import Foundation
import Alamofire
import PKHUD

class Network {
    
    class func request(_ url: URL, method: HTTPMethod = .get, parameters: [String: Any]? = nil, log: Bool = true, encoding: ParameterEncoding = JSONEncoding.default, completion: @escaping (DataResponse<Any>) -> Void) {
        
        HUD.show(.progress)
        
        Alamofire.request(url, method: method, parameters: parameters, encoding: encoding, headers: defaultHeaders()).responseJSON(completionHandler: { response in
            
            if log {
                logAlamofireRequest(response: response)
            }
            
            HUD.hide()
            completion(response)
        })
    }
    
    private class func defaultHeaders() -> [String: String] {
        
        let headers: [String: String] = [
            "Content-Type":"application/json",
            "Authorization": "Bearer \(UserSession.shared.accessToken)",
            "trakt-api-version": "2",
            "trakt-api-key": TraktAPI.clientId
        ]
        
        return headers
    }
    
    private class func logAlamofireRequest(response: DataResponse<Any>) {
        
        guard let request = response.request else { return }
        guard let url = request.url else { return }
        guard let httpMethod = request.httpMethod else { return }
        
        print("->REQUEST(\(httpMethod))\n\(url)\n")
        
        if let requestHeaders = request.allHTTPHeaderFields {
            print("->HEADERS\n\(requestHeaders)\n")
        }
        
        if let httpBody = request.httpBody {
            do {
                let jsonBody = try JSONSerialization.jsonObject(with: httpBody)
                print("->BODY\n\(jsonBody)\n")
            } catch {
                
            }
        }
        
        var statusCode = 0
        if let response = response.response {
            statusCode = response.statusCode
        }
        
        let statusCodeString = (statusCode != 0) ? "(\(statusCode))" : ""
        print("->RESPONSE" + statusCodeString + "\n\(response.description)")
    }
}

