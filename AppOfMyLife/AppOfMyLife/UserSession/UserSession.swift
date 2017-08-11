//
//  UserSession.swift
//  AppOfMyLife
//
//  Created by Giovane Possebon on 9/8/17.
//  Copyright © 2017 giovane. All rights reserved.
//

import Foundation
import ObjectMapper

struct UserSessionKeys {
    static let accessToken = "accessToken"
}

class UserSession {
    static var shared = UserSession()
    
    var accessToken: String {
        set {
            UserDefaults.standard.set(newValue, forKey: UserSessionKeys.accessToken)
            UserDefaults.standard.synchronize()
        } get {
            return UserDefaults.standard.value(forKey: UserSessionKeys.accessToken) as? String ?? ""
        }
    }
}
