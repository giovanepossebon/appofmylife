//
//  HomeService.swift
//  AppOfMyLife
//
//  Created by Giovane Possebon on 10/8/17.
//  Copyright © 2017 giovane. All rights reserved.
//

import Foundation

private enum Endpoint {
    case scheduledShows(request: HomeServiceRequest)
    
    var url: String {
        switch self {
        case .scheduledShows(request: let request):
            return TraktAPI.URLs.baseURL + "calendars/my/shows/\(request.startDate)/\(request.days)"
        }
    }
}

struct HomeServiceRequest {
    let startDate: String
    let days: Int
}

struct HomeService: HomeApiClient {
    
    static let BASE_URL = TraktAPI.URLs.baseURL
    
    static func getMySchedule(request: HomeServiceRequest, callback: @escaping (Response<[Schedule]>) -> ()) {

        guard let url = URL(string: Endpoint.scheduledShows(request: request).url) else {
            callback(Response<[Schedule]>(data: [], result: .error(message: "URL invalida")))
            return
        }
        
        Network.request(url, method: .get, log: false) { response in
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
