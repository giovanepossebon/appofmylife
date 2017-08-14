//
//  LoginApiClient.swift
//  AppOfMyLife
//
//  Created by Giovane Possebon on 14/8/17.
//  Copyright © 2017 giovane. All rights reserved.
//

import Foundation

protocol LoginApiClient {
    static func getToken(code: String, callback: @escaping (Response<Auth>) -> ())
}
