//
//  ProfilePresenter.swift
//  AppOfMyLife
//
//  Created by Giovane Possebon on 13/8/17.
//  Copyright © 2017 giovane. All rights reserved.
//

import Foundation

protocol ProfileViewPresenter {
    init(view: ProfileView)
    func loadProfile()
    func loadStats(fromUser user: User)
}

class ProfilePresenter: ProfileViewPresenter {
    unowned let view: ProfileView
    
    required init(view: ProfileView) {
        self.view = view
    }
    
    func loadProfile() {
        UserService.getUserSettings { response in
            switch response.result {
            case .success:
                guard let userSettings = response.data else {
                    self.view.onLoadError(error: "Invalid Data")
                    return
                }
                
                self.view.onProfileLoaded(userSettings: userSettings)
            case .error(message: let error):
                self.view.onLoadError(error: error)
            }
        }
    }
    
    func loadStats(fromUser user: User) {
        StatsService.getStats(fromUser: user) { response in
            switch response.result {
            case .success:
                guard let stats = response.data else {
                    self.view.onLoadError(error: "Invalid Data")
                    return
                }
                
                self.view.onStatsLoaded(stats: stats)
            case .error(message: let error):
                self.view.onLoadError(error: error)
            }
        }
    }
}
