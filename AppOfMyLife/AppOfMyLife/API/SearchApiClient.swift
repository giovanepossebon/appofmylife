//
//  SearchApiClient.swift
//  AppOfMyLife
//
//  Created by Giovane Possebon on 15/8/17.
//  Copyright © 2017 giovane. All rights reserved.
//

import Foundation

protocol SearchApiClient {
    //http://docs.trakt.apiary.io/#reference/search/text-query/get-text-query-results
    static func search(withQuery query: String, callback: @escaping (Response<[SearchResult]>) -> ())
}
