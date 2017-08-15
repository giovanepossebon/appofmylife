//
//  CollectionApiClient.swift
//  AppOfMyLife
//
//  Created by Giovane Possebon on 14/8/17.
//  Copyright © 2017 giovane. All rights reserved.
//

import Foundation

protocol CollectionApiClient {
    static func getShowCollection(callback: @escaping (Response<[ShowCollection]>) -> ())
}
