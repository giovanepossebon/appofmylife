//
//  UserApiClient.swift
//  AppOfMyLife
//
//  Created by Giovane Possebon on 14/8/17.
//  Copyright © 2017 giovane. All rights reserved.
//

import Foundation

protocol UserApiClient {
    // http://docs.trakt.apiary.io/#reference/users/settings/retrieve-settings
    static func getUserSettings(callback: @escaping (Response<UserSettings>) -> ())
}
