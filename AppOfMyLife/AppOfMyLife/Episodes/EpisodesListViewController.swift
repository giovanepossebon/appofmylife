//
//  EpisodesListViewController.swift
//  AppOfMyLife
//
//  Created by Giovane Possebon on 13/8/17.
//  Copyright © 2017 giovane. All rights reserved.
//

import UIKit

protocol EpisodeListView: class {
    func onEpisodeListLoaded(episodes: [Episode])
    func onLoadError(error: String)
}

class EpisodesListViewController: UITableViewController {
    
    var show: Show!
    var season: Season!
    var presenter: EpisodesListViewPresenter!
    
    var episodes: [Episode]? {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        
        self.title = "Episodes"
        
        presenter = EpisodesListPresenter(view: self)
        presenter.loadEpisodeList(fromShow: show, season: season)
    }
    
    private func setupTableView() {
        tableView.register(UINib(nibName: TitleWithAccessoryCell.nibName, bundle: nil), forCellReuseIdentifier: TitleWithAccessoryCell.identifier)
    }
    
}

extension EpisodesListViewController: EpisodeListView {
    
    func onEpisodeListLoaded(episodes: [Episode]) {
        self.episodes = episodes
    }
    
    func onLoadError(error: String) {
        print(error)
    }
    
}

extension EpisodesListViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodes?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: TitleWithAccessoryCell.identifier, for: indexPath) as? TitleWithAccessoryCell {
            if let episode = episodes?[indexPath.row] {
                cell.populate(withTitle: episode.numberedEpisodeName(), withAccessoryType: .disclosureIndicator)
            }
            
            return cell
        }
        
        return UITableViewCell()
    }
    
}

extension EpisodesListViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let detailViewController = storyboard?.instantiateViewController(withIdentifier: "EpisodeDetailViewController") as? EpisodeDetailViewController {
            if let episode = episodes?[indexPath.row] {
                detailViewController.show = show
                detailViewController.episode = episode
                navigationController?.pushViewController(detailViewController, animated: true)
            }
        }
    }
    
}
