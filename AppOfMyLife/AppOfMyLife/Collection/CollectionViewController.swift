//
//  CollectionViewController.swift
//  AppOfMyLife
//
//  Created by Giovane Possebon on 11/8/17.
//  Copyright © 2017 giovane. All rights reserved.
//

import UIKit

protocol CollectionView: class {
    func onCollectionLoaded(collections: [ShowCollection])
    func onLoadFailed(error: String)
}

class CollectionViewController: UICollectionViewController {
    
    var presenter: CollectionViewPresenter?
    var collections: [ShowCollection]? {
        didSet {
            collectionView?.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = CollectionPresenter(view: self)
        setupCollectionView()
        
        presenter?.loadCollection()
    }
    
    private func setupCollectionView() {
        collectionView?.register(UINib(nibName: CollectionItemCell.nibName, bundle: nil), forCellWithReuseIdentifier: CollectionItemCell.identifier)
    }
    
}

extension CollectionViewController: CollectionView {
    
    func onCollectionLoaded(collections: [ShowCollection]) {
        self.collections = collections
    }
    
    func onLoadFailed(error: String) {
        showHUD(withMessage: error)
    }
    
}

// MARK: CollectionViewDataSource

extension CollectionViewController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collections?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionItemCell.identifier, for: indexPath) as? CollectionItemCell {
            guard let collection = collections?[indexPath.row] else {
                return UICollectionViewCell()
            }
            
            cell.populate(withCollection: collection)
            
            return cell
        }
        
        return UICollectionViewCell()
    }
    
}

// MARK: CollectionViewDelegate

extension CollectionViewController {
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let selectedShow = collections?[indexPath.row].show {
            if let detailViewController = ShowDetailViewController.instance(withShow: selectedShow) {
                navigationController?.pushViewController(detailViewController, animated: true)
            }
        }
    }
    
}

// MARK: CollectionViewDelegate

extension CollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let margin: CGFloat = 20
        let halfWidth = (UIScreen.main.bounds.width / 2.0) - margin
        return CGSize(width: halfWidth, height: CollectionItemCell.height + margin)
    }
    
}
