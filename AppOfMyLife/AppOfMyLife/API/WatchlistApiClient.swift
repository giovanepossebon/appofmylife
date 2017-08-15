//
//  WatchlistApiClient.swift
//  AppOfMyLife
//
//  Created by Giovane Possebon on 15/8/17.
//  Copyright © 2017 giovane. All rights reserved.
//

import Foundation

protocol WatchlistApiClient {
    // http://docs.trakt.apiary.io/#reference/sync/add-to-watchlist/add-items-to-watchlist
    static func syncWatchlist(withShow show: Show, callback: @escaping (Response<WatchlistSync>) -> ())
}
