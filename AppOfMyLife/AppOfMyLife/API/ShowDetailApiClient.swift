//
//  ShowDetailApiClient.swift
//  AppOfMyLife
//
//  Created by Giovane Possebon on 14/8/17.
//  Copyright © 2017 giovane. All rights reserved.
//

import Foundation

protocol ShowDetailApiClient {
    // http://docs.trakt.apiary.io/#reference/shows/collection-progress/get-show-watched-progress
    static func getShowDetail(request: ShowDetailRequest, callback: @escaping (Response<Show>) -> ())
    // http://docs.trakt.apiary.io/#reference/shows/summary/get-a-single-show
    static func getShowProgress(request: ShowDetailRequest, callback: @escaping (Response<ShowProgress>) -> ())
    // http://docs.trakt.apiary.io/#reference/shows/next-episode/get-next-episode
    static func getNextEpisode(request: ShowDetailRequest, callback: @escaping (Response<Episode>) -> ())
}
