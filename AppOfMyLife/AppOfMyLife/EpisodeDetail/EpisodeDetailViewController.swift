//
//  EpisodeDetailViewController.swift
//  AppOfMyLife
//
//  Created by Giovane Possebon on 12/8/17.
//  Copyright © 2017 giovane. All rights reserved.
//

import UIKit

private enum DetailRows: Int {
    case image
    case description
    
    static let count = DetailRows.description.hashValue + 1
}

protocol EpisodeDetailView: class {
    func onEpisodeDetailLoaded(episode: Episode)
    func onLoadError(error: String)
}

class EpisodeDetailViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var presenter: EpisodeDetailPresenter?
    var show: Show!
    var episode: Episode!
    
    var episodeDetail: Episode? {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        
        self.title = episode.title
        
        presenter = EpisodeDetailPresenter(view: self)
        presenter?.loadEpisodeDetail(fromShow: show, episode: episode)
    }
    
    private func setupTableView() {
        tableView.register(UINib(nibName: ImageCell.nibName, bundle: nil), forCellReuseIdentifier: ImageCell.identifier)
        tableView.register(UINib(nibName: DescriptionCell.nibName, bundle: nil), forCellReuseIdentifier: DescriptionCell.identifier)
        tableView.separatorStyle = .none
    }
}

extension EpisodeDetailViewController: EpisodeDetailView {
    func onEpisodeDetailLoaded(episode: Episode) {
        episodeDetail = episode
    }

    
    func onLoadError(error: String) {
        print(error)
    }
    
}

extension EpisodeDetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DetailRows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let rowType = DetailRows(rawValue: indexPath.row) else {
            return UITableViewCell()
        }
        
        switch rowType {
        case .image:
            if let cell = tableView.dequeueReusableCell(withIdentifier: ImageCell.identifier, for: indexPath) as? ImageCell {
                
                if let tvdbId = episodeDetail?.ids?.tvdb {
                    cell.populate(withImageUrl: episodeDetail?.getThumbnailImage(forBannerStyle: .portrait(id: tvdbId)))
                }
                
                return cell
            }
        case .description:
            if let cell = tableView.dequeueReusableCell(withIdentifier: DescriptionCell.identifier, for: indexPath) as? DescriptionCell {
                cell.populate(withDescription: episodeDetail?.overview)
                
                return cell
            }
        }
        
        return UITableViewCell()
    }
    
}

extension EpisodeDetailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let rowType = DetailRows(rawValue: indexPath.row) else {
            return 0
        }
        
        switch rowType {
        case .image:
            return ImageCell.height
        case .description:
            return DescriptionCell.height
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
}
