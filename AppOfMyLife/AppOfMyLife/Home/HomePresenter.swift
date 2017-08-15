//
//  HomePresenter.swift
//  AppOfMyLife
//
//  Created by Giovane Possebon on 10/8/17.
//  Copyright © 2017 giovane. All rights reserved.
//

import Foundation

protocol HomeViewPresenter {
    init(view: HomeView)
    func loadSchedule()
}

class HomePresenter: HomeViewPresenter {
    unowned let view: HomeView
    
    required init(view: HomeView) {
        self.view = view
    }
    
    func loadSchedule() {
        let request = HomeServiceRequest(startDate: Date().ISOStringFromDate(withDateFormat: .traktAPI), days: 14)
        
        HomeService.getMySchedule(request: request) { response in
            switch response.result{
            case .success:
                guard let schedule = response.data?.filter({ Date.dateFromISOString(string: $0.firstAired ?? "") > Date() }) else {
                    self.view.onLoadFailed(error: "Invalid data")
                    return
                }
                
                self.view.onScheduleLoaded(schedule: schedule)
            case .error(message: let error):
                self.view.onLoadFailed(error: error)
            }
        }
    }
    
}
