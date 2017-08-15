//
//  ShowDetailPresenter.swift
//  AppOfMyLife
//
//  Created by Giovane Possebon on 12/8/17.
//  Copyright © 2017 giovane. All rights reserved.
//

import Foundation

protocol ShowDetailViewPresenter {
    init(view: ShowDetailView)
    func loadShowDetail(fromShow show: Show)
    func loadShowProgress(fromShow show: Show)
    func loadNextEpisode(fromShow show: Show)
}

class ShowDetailPresenter: ShowDetailViewPresenter {
    unowned let view: ShowDetailView
    
    required init(view: ShowDetailView) {
        self.view = view
    }
    
    func loadShowDetail(fromShow show: Show) {
        let request = ShowDetailRequest(showId: show.ids?.slug ?? "")
        
        ShowDetailService.getShowDetail(request: request) { response in
            switch response.result {
            case .success:
                guard let showDetail = response.data else {
                    self.view.onError(error: "Failed to load show detail")
                    return
                }
                
                self.view.onShowDetailLoaded(showDetail: showDetail)
            case .error(message: let error):
                self.view.onError(error: error)
            }
        }
    }
    
    func loadShowProgress(fromShow show: Show) {
        let request = ShowDetailRequest(showId: show.ids?.slug ?? "")
        
        ShowDetailService.getShowProgress(request: request) { response in
            switch response.result {
            case .success:
                guard let progress = response.data else {
                    self.view.onError(error: "Failed to load show detail")
                    return
                }
                
                self.view.onShowProgressLoaded(showProgress: progress)
            case .error(message: let error):
                self.view.onError(error: error)
            }
        }
    }
    
    func loadNextEpisode(fromShow show: Show) {
        let request = ShowDetailRequest(showId: show.ids?.slug ?? "")
        
        ShowDetailService.getNextEpisode(request: request) { response in
            switch response.result {
            case .success:
                guard let nextEpisode = response.data else {
                    self.view.onError(error: "Failed to load show detail")
                    return
                }
                
                self.view.onNextEpisodeLoaded(nextEpisode: nextEpisode)
            case .error(message: let error):
                self.view.onError(error: error)
            }
        }
    }
}
