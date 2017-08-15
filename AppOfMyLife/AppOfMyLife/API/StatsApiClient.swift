//
//  StatsApiClient.swift
//  AppOfMyLife
//
//  Created by Giovane Possebon on 14/8/17.
//  Copyright © 2017 giovane. All rights reserved.
//

import Foundation

protocol StatsApiClient {
    // http://docs.trakt.apiary.io/#reference/users/stats/get-stats
    static func getStats(request: StatsRequest, callback: @escaping (Response<Stats>) -> ())
}
