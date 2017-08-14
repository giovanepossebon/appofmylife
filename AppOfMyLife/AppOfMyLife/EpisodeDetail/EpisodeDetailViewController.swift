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
    case date
    case description
    case historyButton
    
    static let count = DetailRows.historyButton.hashValue + 1
}

protocol EpisodeDetailView: class {
    func onEpisodeDetailLoaded(episode: Episode)
    func onEpisodeHistoryLoaded(history: History)
    func onHistorySynced()
    func onLoadError(error: String)
}

class EpisodeDetailViewController: UIViewController {
    
    static let identifier = "EpisodeDetailViewController"
    
    @IBOutlet weak var tableView: UITableView!
    
    var presenter: EpisodeDetailPresenter?
    var show: Show!
    var episode: Episode!
    
    var episodeDetail: Episode? {
        didSet {
            reloadTableView(forDetailRow: .description)
            reloadTableView(forDetailRow: .date)
            reloadTableView(forDetailRow: .image)
        }
    }
    
    var episodeHistory: History? {
        didSet {
            reloadTableView(forDetailRow: .historyButton)
        }
    }
    
    private func reloadTableView(forDetailRow row: DetailRows) {
        tableView.reloadRows(at: [IndexPath(row: row.hashValue, section: 0)], with: .automatic)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        
        self.title = episode.fullEpisodeName()
        
        presenter = EpisodeDetailPresenter(view: self)
        presenter?.loadEpisodeDetail(fromShow: show, episode: episode)
        presenter?.loadHistory(fromEpisode: episode)
    }
    
    private func setupTableView() {
        tableView.register(UINib(nibName: ImageCell.nibName, bundle: nil), forCellReuseIdentifier: ImageCell.identifier)
        tableView.register(UINib(nibName: DescriptionCell.nibName, bundle: nil), forCellReuseIdentifier: DescriptionCell.identifier)
        tableView.register(UINib(nibName: EpisodeDateCell.nibName, bundle: nil), forCellReuseIdentifier: EpisodeDateCell.identifier)
        tableView.register(UINib(nibName: ButtonCell.nibName, bundle: nil), forCellReuseIdentifier: ButtonCell.identifier)
        tableView.separatorStyle = .none
    }
}

extension EpisodeDetailViewController: EpisodeDetailView {
    
    func onEpisodeDetailLoaded(episode: Episode) {
        episodeDetail = episode
    }
    
    func onEpisodeHistoryLoaded(history: History) {
        episodeHistory = history
    }

    func onHistorySynced() {
        print("message")
        presenter?.loadHistory(fromEpisode: episode)
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
                
                if let tvdbId = show?.ids?.tvdb {
                    cell.populate(withImageUrl: episodeDetail?.getThumbnailImage(forBannerStyle: .portrait(id: tvdbId, variation: 3)))
                }
                
                return cell
            }
        
        case .date:
            if let cell = tableView.dequeueReusableCell(withIdentifier: EpisodeDateCell.identifier, for: indexPath) as? EpisodeDateCell {
                if let episode = episodeDetail {
                    cell.populate(withEpisode: episode)
                }
                
                return cell
            }
        
        case .description:
            if let cell = tableView.dequeueReusableCell(withIdentifier: DescriptionCell.identifier, for: indexPath) as? DescriptionCell {
                cell.populate(withDescription: episodeDetail?.overview)
                
                return cell
            }
        case .historyButton:
            if let cell = tableView.dequeueReusableCell(withIdentifier: ButtonCell.identifier, for: indexPath) as? ButtonCell {
                
                cell.delegate = self
                
                if let _ = episodeHistory {
                    cell.populate(withTitle: "Watched", color: .purple)
                } else {
                    cell.populate(withTitle: "Mark as Watched", color: .green)
                }
                
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
        case .date:
            return EpisodeDateCell.height
        case .description:
            return DescriptionCell.height
        case .historyButton:
            return ButtonCell.height
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let rowType = DetailRows(rawValue: indexPath.row) else {
            return 0
        }
        
        switch rowType {
        case .image:
            return ImageCell.height
        case .description, .date, .historyButton:
            return UITableViewAutomaticDimension
        }
    }
    
}

extension EpisodeDetailViewController: ButtonCellDelegate {
    
    func onButtonTouched() {
        presenter?.syncHistory(withEpisode: episode)
    }
    
}
