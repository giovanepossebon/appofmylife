//
//  HistoryApiClient.swift
//  AppOfMyLife
//
//  Created by Giovane Possebon on 14/8/17.
//  Copyright © 2017 giovane. All rights reserved.
//

import Foundation

protocol HistoryApiClient {
    // http://docs.trakt.apiary.io/#reference/sync/get-history/get-watched-history
    static func getEpisodeHistory(request: HistoryRequest, callback: @escaping (Response<[History]>) -> ())
    // http://docs.trakt.apiary.io/#reference/sync/add-to-history/add-items-to-watched-history
    static func syncHistory(withEpisode episode: Episode, callback: @escaping (Response<Result>) -> ())
}
