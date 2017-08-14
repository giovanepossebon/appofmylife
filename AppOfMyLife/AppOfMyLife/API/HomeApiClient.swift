//
//  HomeApiClient.swift
//  AppOfMyLife
//
//  Created by Giovane Possebon on 14/8/17.
//  Copyright © 2017 giovane. All rights reserved.
//

import Foundation

protocol HomeApiClient {
    // http://docs.trakt.apiary.io/#reference/calendars/get-shows
    static func getMySchedule(callback: @escaping (Response<[Schedule]>) -> ())
}
