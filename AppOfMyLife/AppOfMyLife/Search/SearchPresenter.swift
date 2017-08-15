//
//  SearchPresenter.swift
//  AppOfMyLife
//
//  Created by Giovane Possebon on 15/8/17.
//  Copyright © 2017 giovane. All rights reserved.
//

import Foundation

protocol SearchViewPresenter {
    init(view: SearchView)
    func searchWithText(text: String)
}

class SearchPresenter: SearchViewPresenter {
    unowned let view: SearchView
    
    required init(view: SearchView) {
        self.view = view
    }
    
    func searchWithText(text: String) {
        SearchService.search(withQuery: text) { response in
            switch response.result {
            case .success:
                guard let shows = response.data else {
                    self.view.onSearchError(error: "Invalid data")
                    return
                }
                
                self.view.onSearchFinished(shows: shows)
            case .error(message: let error):
                self.view.onSearchError(error: error)
            }
        }
    }
}
