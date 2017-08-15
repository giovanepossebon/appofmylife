//
//  EpisodesListPresenter.swift
//  AppOfMyLife
//
//  Created by Giovane Possebon on 13/8/17.
//  Copyright © 2017 giovane. All rights reserved.
//

import Foundation

protocol EpisodesListViewPresenter {
    init(view: EpisodeListView)
    func loadEpisodeList(fromShow show: Show, season: Season)
}

class EpisodesListPresenter: EpisodesListViewPresenter {
    unowned let view: EpisodeListView
    
    required init(view: EpisodeListView) {
        self.view = view
    }
    
    func loadEpisodeList(fromShow show: Show, season: Season) {
        let request = EpisodeListRequest(slug: show.ids?.slug ?? "",
                                         seasonNumber: season.number ?? 0)
        
        EpisodeService.getEpisodeList(request: request) { response in
            switch response.result {
            case .success:
                guard let episodes = response.data else {
                    self.view.onLoadError(error: "Invalid Data")
                    return
                }
                
                self.view.onEpisodeListLoaded(episodes: episodes)
            case .error(message: let error):
                self.view.onLoadError(error: error)
            }
        }
    }
    
}
