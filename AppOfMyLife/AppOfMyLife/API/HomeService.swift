//
//  HomeService.swift
//  AppOfMyLife
//
//  Created by Giovane Possebon on 10/8/17.
//  Copyright © 2017 giovane. All rights reserved.
//

import Foundation

private struct Endpoint {
    static let scheduledShows = "/calendars/my/shows/"   // http://docs.trakt.apiary.io/#reference/calendars/get-shows
}

struct HomeService {
    
    static let BASE_URL = TraktAPI.URLs.baseURL
    static let defaultNumberOfDays = 14
    
    static func getMySchedule(callback: @escaping (Response<[Schedule]>) -> ()) {
        let params: [String: Any] = [
            "start_date": Date().traktApiFormatedData(),
            "days": defaultNumberOfDays
        ]
        
        guard let url = URL(string: "\(BASE_URL + Endpoint.scheduledShows)") else {
            callback(Response<[Schedule]>(data: [], result: Result.error(message: "URL invalida")))
            return
        }
        
        Network.request(url, method: .get, parameters: params, log: true) { response in
            switch response.result {
            case .success:
                guard let data = response.result.value as? [[String:Any]] else {
                    callback(Response<[Schedule]>(data: [], result: Result.error(message: "Erro ao parsear")))
                    return
                }
                
                let schedule = data.flatMap { Schedule(JSON: $0) }
                callback(Response<[Schedule]>(data: schedule, result: Result.success))
            case .failure(let error):
                callback(Response<[Schedule]>(data: [], result: Result.error(message: error.localizedDescription)))
            }
        }
    }
    
}
