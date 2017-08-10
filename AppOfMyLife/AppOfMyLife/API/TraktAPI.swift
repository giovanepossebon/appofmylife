//
//  Trakt.swift
//  AppOfMyLife
//
//  Created by Giovane Possebon on 9/8/17.
//  Copyright © 2017 giovane. All rights reserved.
//

import Foundation

struct TraktAPI {
    static let clientId = "645b105507c99c7848e449c47669e9b41350ffa76a35aaa8df300b51705d359d"
    static let clientSecret = "6823613d6ccdb93a6f468a7c2b7d8d8bb24818bd1d8f6810f28b393396f42634"
    static let redirectUri = "com.giovane.appofmylife://auth"
    static let responseType = "code"
    
    struct URLs {
        static let loginURL: URL? = URL(string: String(format: "https://trakt.tv/oauth/authorize?response_type=%@&client_id=%@&redirect_uri=%@", responseType, clientId, redirectUri))
        static let authURL = "https://api.trakt.tv/oauth/token"
    }
}
