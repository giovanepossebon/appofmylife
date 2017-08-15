//
//  SeasonApiClient.swift
//  AppOfMyLife
//
//  Created by Giovane Possebon on 14/8/17.
//  Copyright © 2017 giovane. All rights reserved.
//

import Foundation

protocol SeasonApiClient {
    // http://docs.trakt.apiary.io/#reference/seasons/summary/get-all-seasons-for-a-show
    static func getSeasonsList(request: SeasonListRequest, callback: @escaping (Response<[Season]>) -> ())
}
