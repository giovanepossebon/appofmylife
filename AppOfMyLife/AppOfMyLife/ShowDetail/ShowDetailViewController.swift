//
//  ShowDetailViewController.swift
//  AppOfMyLife
//
//  Created by Giovane Possebon on 12/8/17.
//  Copyright © 2017 giovane. All rights reserved.
//

import UIKit

private enum DetailRows: Int {
    case image
    case description
    case progress
    case nextEpisodeHeader
    case nextEpisode
    
    static let count = DetailRows.nextEpisode.hashValue + 1
}

protocol ShowDetailView: class {
    func onShowDetailLoaded(showDetail: Show)
    func onShowProgressLoaded(showProgress: Progress)
    func onNextEpisodeLoaded(nextEpisode: Episode)
    func onError(error: String)
}

class ShowDetailViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var presenter: ShowDetailViewPresenter?
    var show: Show!
    
    var showDetail: Show? {
        didSet {
            tableView.reloadData()
        }
    }
    
    var showProgress: Progress? {
        didSet {
            reloadTableView(forDetailRow: .progress)
        }
    }
    
    var nextEpisode: Episode? {
        didSet {
            reloadTableView(forDetailRow: .nextEpisode)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        
        self.title = show.title
        
        presenter = ShowDetailPresenter(view: self)
        presenter?.loadShowDetail(fromShow: show)
        presenter?.loadShowProgress(fromShow: show)
        presenter?.loadNextEpisode(fromShow: show)
    }
    
    private func setupTableView() {
        tableView.register(UINib(nibName: ImageCell.nibName, bundle: nil), forCellReuseIdentifier: ImageCell.identifier)
        tableView.register(UINib(nibName: DescriptionCell.nibName, bundle: nil), forCellReuseIdentifier: DescriptionCell.identifier)
        tableView.register(UINib(nibName: ProgressCell.nibName, bundle: nil), forCellReuseIdentifier: ProgressCell.identifier)
        tableView.register(UINib(nibName: TitleWithAccessoryCell.nibName, bundle: nil), forCellReuseIdentifier: TitleWithAccessoryCell.identifier)
        tableView.register(UINib(nibName: TitleHeaderSection.nibName, bundle: nil), forCellReuseIdentifier: TitleHeaderSection.identifier)
        tableView.separatorStyle = .none
    }
    
    private func reloadTableView(forDetailRow row: DetailRows) {
        tableView.reloadRows(at: [IndexPath(row: row.hashValue, section: 0)], with: .automatic)
    }
    
}

extension ShowDetailViewController: ShowDetailView {
    
    func onShowDetailLoaded(showDetail: Show) {
        self.showDetail = showDetail
    }
    
    func onShowProgressLoaded(showProgress: Progress) {
        self.showProgress = showProgress
    }
    
    func onNextEpisodeLoaded(nextEpisode: Episode) {
        self.nextEpisode = nextEpisode
    }
    
    func onError(error: String) {
        print(error)
    }
}

extension ShowDetailViewController: UITableViewDataSource {
    
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
                
                if let tvdbId = showDetail?.ids?.tvdb {
                    cell.populate(withImageUrl: showDetail?.getThumbnailImage(forBannerStyle: .portrait(id: tvdbId)))
                }
                
                return cell
            }
        case .description:
            if let cell = tableView.dequeueReusableCell(withIdentifier: DescriptionCell.identifier, for: indexPath) as? DescriptionCell {
                cell.populate(withDescription: showDetail?.overview)
                
                return cell
            }
            
        case .progress:
            if let cell = tableView.dequeueReusableCell(withIdentifier: ProgressCell.identifier, for: indexPath) as? ProgressCell {
                guard let progress = showProgress else {
                    return UITableViewCell()
                }
                
                cell.populate(withProgress: progress)
                
                return cell
            }
        case .nextEpisodeHeader:
            if let cell = tableView.dequeueReusableCell(withIdentifier: TitleHeaderSection.identifier, for: indexPath) as? TitleHeaderSection {
                cell.labelTitle.text = "Next episode..."
                
                return cell
            }
        case .nextEpisode:
            if let cell = tableView.dequeueReusableCell(withIdentifier: TitleWithAccessoryCell.identifier, for: indexPath) as? TitleWithAccessoryCell {
                
                if nextEpisode == nil {
                    cell.populate(withTitle: "There's no new episodes", withAccessoryType: .none, enabled: false)
                } else {
                    cell.populate(withTitle: nextEpisode?.formattedEpisodeName() ?? "", withAccessoryType: .disclosureIndicator)
                }
                
                return cell
            }
        }
        
        return UITableViewCell()
    }
    
}

extension ShowDetailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == DetailRows.nextEpisode.hashValue {
            if let nextEpisode = nextEpisode, let episodeDetailViewController = storyboard?.instantiateViewController(withIdentifier: "EpisodeDetailViewController") as? EpisodeDetailViewController {
                episodeDetailViewController.episode = nextEpisode
                episodeDetailViewController.show = show
                navigationController?.pushViewController(episodeDetailViewController, animated: true)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let rowType = DetailRows(rawValue: indexPath.row) else {
            return 0
        }
        
        switch rowType {
        case .image:
            return ImageCell.height
        case .description:
            return DescriptionCell.height
        case .progress:
            return ProgressCell.height
        case .nextEpisodeHeader:
            return TitleHeaderSection.height
        case .nextEpisode:
            return TitleWithAccessoryCell.height
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
}
