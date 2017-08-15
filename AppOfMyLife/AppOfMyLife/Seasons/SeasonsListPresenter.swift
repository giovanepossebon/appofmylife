//
//  SeasonsListPresenter.swift
//  AppOfMyLife
//
//  Created by Giovane Possebon on 13/8/17.
//  Copyright © 2017 giovane. All rights reserved.
//

import Foundation

protocol SeasonsListViewPresenter {
    init(view: SeasonListView)
    func loadSeasonList(fromShow show: Show)
}

class SeasonsListPresenter: SeasonsListViewPresenter {
    unowned let view: SeasonListView
    
    required init(view: SeasonListView) {
        self.view = view
    }
    
    func loadSeasonList(fromShow show: Show) {
        let request = SeasonListRequest(slug: show.ids?.slug ?? "")
        
        SeasonService.getSeasonsList(request: request) { response in
            switch response.result {
            case .success:
                guard let seasons = response.data else {
                    self.view.onLoadError(error: "Invalid Data")
                    return
                }
                
                self.view.onSeasonListLoaded(seasons: seasons)
            case .error(message: let error):
                self.view.onLoadError(error: error)
            }
        }
    }
    
}
