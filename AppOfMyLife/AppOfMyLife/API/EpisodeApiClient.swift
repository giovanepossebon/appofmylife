//
//  EpisodeApiClient.swift
//  AppOfMyLife
//
//  Created by Giovane Possebon on 14/8/17.
//  Copyright © 2017 giovane. All rights reserved.
//

import Foundation

protocol EpisodeApiClient {
    static func getEpisodeList(request: EpisodeListRequest, callback: @escaping (Response<[Episode]>) -> ())
    // http://docs.trakt.apiary.io/#reference/episodes/summary/get-a-single-episode-for-a-show
    static func getEpisodeDetail(request: EpisodeDetailRequest, callback: @escaping (Response<Episode>) -> ())
}
