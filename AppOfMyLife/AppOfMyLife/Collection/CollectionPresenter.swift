//
//  CollectionPresenter.swift
//  AppOfMyLife
//
//  Created by Giovane Possebon on 11/8/17.
//  Copyright © 2017 giovane. All rights reserved.
//

import Foundation

protocol CollectionViewPresenter {
    init(view: CollectionView)
    func loadCollection()
}

class CollectionPresenter: CollectionViewPresenter {
    unowned let view: CollectionView
    
    required init(view: CollectionView) {
        self.view = view
    }
    
    func loadCollection() {
        CollectionService.getShowCollection { response in
            switch response.result {
            case .success:
                guard let collections = response.data else {
                    self.view.onLoadFailed(error: "Invalid data")
                    return
                }
                
                self.view.onCollectionLoaded(collections: collections)
            case .error(message: let error):
                self.view.onLoadFailed(error: error)
            }
        }
    }
    
}
