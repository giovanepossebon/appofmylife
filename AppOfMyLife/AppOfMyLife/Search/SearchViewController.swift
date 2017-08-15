//
//  SearchViewController.swift
//  AppOfMyLife
//
//  Created by Giovane Possebon on 15/8/17.
//  Copyright © 2017 giovane. All rights reserved.
//

import UIKit

protocol SearchView: class {
    func onSearchFinished(shows: [SearchResult])
    func onSearchError(error: String)
}

class SearchViewController: UICollectionViewController {
    
    var searchController : UISearchController!
    var presenter: SearchViewPresenter?
    var shows: [SearchResult]? {
        didSet {
            collectionView?.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupSearchBar()
        
        presenter = SearchPresenter(view: self)
    }
    
    private func setupCollectionView() {
        collectionView?.register(UINib(nibName: CollectionItemCell.nibName, bundle: nil), forCellWithReuseIdentifier: CollectionItemCell.identifier)
    }
    
    private func setupSearchBar() {
        //Search at the top
        self.searchController = UISearchController(searchResultsController:  nil)
        
        self.searchController.delegate = self
        self.searchController.searchBar.delegate = self
        
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.dimsBackgroundDuringPresentation = true
        self.searchController.obscuresBackgroundDuringPresentation = false
        
        
        searchController.searchBar.becomeFirstResponder()
        self.navigationItem.titleView = searchController.searchBar
    }
    
}

extension SearchViewController: SearchView {
    
    func onSearchFinished(shows: [SearchResult]) {
        self.shows = shows
    }
    
    func onSearchError(error: String) {
        print(error)
    }
    
}

// MARK: CollectionViewDataSource

extension SearchViewController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shows?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionItemCell.identifier, for: indexPath) as? CollectionItemCell {
            guard let show = shows?[indexPath.row].show else {
                return UICollectionViewCell()
            }
            
            cell.populate(withShow: show)
            
            return cell
        }
        
        return UICollectionViewCell()
    }
    
}

// MARK: CollectionViewDelegate

extension SearchViewController {
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let selectedShow = shows?[indexPath.row].show {
            if let detailViewController = ShowDetailViewController.instance(withShow: selectedShow) {
                navigationController?.pushViewController(detailViewController, animated: true)
            }
        }
    }
    
}

// MARK: CollectionViewDelegate

extension SearchViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let margin: CGFloat = 20
        let halfWidth = (UIScreen.main.bounds.width / 2.0) - margin
        return CGSize(width: halfWidth, height: CollectionItemCell.height + margin)
    }
    
}

extension SearchViewController: UISearchControllerDelegate, UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        presenter?.searchWithText(text: searchBar.text ?? "")
    }
    
}
