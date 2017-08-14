//
//  HomeService.swift
//  AppOfMyLife
//
//  Created by Giovane Possebon on 10/8/17.
//  Copyright © 2017 giovane. All rights reserved.
//

import Foundation

private struct Endpoint {
    static let scheduledShows = "/calendars/my/shows/"
}

struct HomeService: HomeApiClient {
    
    static let BASE_URL = TraktAPI.URLs.baseURL
    static let defaultNumberOfDays = 14
    
    static func getMySchedule(callback: @escaping (Response<[Schedule]>) -> ()) {
        let params: [String: Any] = [
            "start_date": Date().ISOStringFromDate(withDateFormat: .traktAPI),
            "days": defaultNumberOfDays
        ]
        
        guard let url = URL(string: "\(BASE_URL + Endpoint.scheduledShows)") else {
            callback(Response<[Schedule]>(data: [], result: .error(message: "URL invalida")))
            return
        }
        
        Network.request(url, method: .get, parameters: params, log: false) { response in
            switch response.result {
            case .success:
                guard let data = response.result.value as? [[String:Any]] else {
                    callback(Response<[Schedule]>(data: [], result: .error(message: "Erro ao parsear")))
                    return
                }
                
                let schedule = data.flatMap { Schedule(JSON: $0) }
                callback(Response<[Schedule]>(data: schedule, result: Result.success))
            case .failure(let error):
                callback(Response<[Schedule]>(data: [], result: .error(message: error.localizedDescription)))
            }
        }
    }
    
}
