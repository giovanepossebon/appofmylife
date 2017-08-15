//
//  SeasonsListViewController.swift
//  AppOfMyLife
//
//  Created by Giovane Possebon on 13/8/17.
//  Copyright © 2017 giovane. All rights reserved.
//

import UIKit

protocol SeasonListView: class {
    func onSeasonListLoaded(seasons: [Season])
    func onLoadError(error: String)
}

class SeasonsListViewController: UITableViewController {
    
    var show: Show!
    var presenter: SeasonsListViewPresenter!
    
    var seasons: [Season]? {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        
        self.title = "Seasons"
        
        presenter = SeasonsListPresenter(view: self)
        presenter.loadSeasonList(fromShow: show)
    }
    
    static func instance(withShow show: Show) -> SeasonsListViewController? {
        let viewController: SeasonsListViewController? = SeasonsListViewController.create(storyboardName: "Collection")
        viewController?.setup(show: show)
        return viewController
    }
    
    private func setup(show: Show) {
        self.show = show
    }
    
    private func setupTableView() {
        tableView.register(UINib(nibName: TitleWithAccessoryCell.nibName, bundle: nil), forCellReuseIdentifier: TitleWithAccessoryCell.identifier)
    }
    
}

extension SeasonsListViewController: SeasonListView {
    
    func onSeasonListLoaded(seasons: [Season]) {
        self.seasons = seasons
    }
    
    func onLoadError(error: String) {
        showHUD(withMessage: error)
    }
    
}

// MARK: TableViewDataSource

extension SeasonsListViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return seasons?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: TitleWithAccessoryCell.identifier, for: indexPath) as? TitleWithAccessoryCell {
            if let season = seasons?[indexPath.row], let number = season.number {
                cell.populate(withTitle: "Season \(number)", withAccessoryType: .disclosureIndicator)
            }
            
            return cell
        }
        
        return UITableViewCell()
    }
    
}

// MARK: TableViewDelegate

extension SeasonsListViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let season = seasons?[indexPath.row], let episodeListViewController = EpisodesListViewController.instance(withShow: show, season: season) {
            navigationController?.pushViewController(episodeListViewController, animated: true)
        }
    }
    
}
