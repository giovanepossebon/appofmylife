//
//  EpisodeDetailPresenter.swift
//  AppOfMyLife
//
//  Created by Giovane Possebon on 12/8/17.
//  Copyright © 2017 giovane. All rights reserved.
//

import Foundation

protocol EpisodeDetailViewPresenter {
    init(view: EpisodeDetailView)
    func loadEpisodeDetail(fromShow show: Show, episode: Episode)
    func loadHistory(fromEpisode episode: Episode)
    func syncHistory(withEpisode episode: Episode)
}

class EpisodeDetailPresenter: EpisodeDetailViewPresenter {
    unowned let view: EpisodeDetailView
    
    required init(view: EpisodeDetailView) {
        self.view = view
    }
    
    func loadEpisodeDetail(fromShow show: Show, episode: Episode) {
        EpisodeService.getEpisodeDetail(fromShow: show, episode: episode) { response in
            switch response.result {
            case .success:
                guard let episodeDetail = response.data else {
                    self.view.onLoadError(error: "Invalid data")
                    return
                }
                
                self.view.onEpisodeDetailLoaded(episode: episodeDetail)
            case .error(message: let error):
                self.view.onLoadError(error: error)
            }
        }
    }
    
    func loadHistory(fromEpisode episode: Episode) {
        HistoryService.getEpisodeHistory(episode: episode) { response in
            switch response.result {
            case .success:
                guard let episodeHistory = response.data?.first else {
                    self.view.onLoadError(error: "Invalid data")
                    return
                }
                
                self.view.onEpisodeHistoryLoaded(history: episodeHistory)
            case .error(message: let error):
                self.view.onLoadError(error: error)
            }
        }
    }
    
    func syncHistory(withEpisode episode: Episode) {
        HistoryService.syncHistory(withEpisode: episode) { response in
            switch response.result {
            case .success:
                self.view.onHistorySynced()
            case .error(message: let error):
                self.view.onLoadError(error: error)
            }
        }
    }
    
}
