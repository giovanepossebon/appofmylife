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
    case otherEpisodesHeader
    case seasons
    
    static let count = DetailRows.seasons.hashValue + 1
}

protocol ShowDetailView: class {
    func onShowDetailLoaded(showDetail: Show)
    func onShowProgressLoaded(showProgress: ShowProgress)
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
    
    var showProgress: ShowProgress? {
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
    
    static func instance(withShow show: Show) -> ShowDetailViewController? {
        let viewController: ShowDetailViewController? = ShowDetailViewController.create(storyboardName: "Collection")
        viewController?.setup(show: show)
        return viewController
    }
    
    private func setup(show: Show) {
        self.show = show
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
    
    func onShowProgressLoaded(showProgress: ShowProgress) {
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
                    cell.populate(withImageUrl: showDetail?.getThumbnailImage(forBannerStyle: .portrait(id: tvdbId, variation: 1)))
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
        case .nextEpisodeHeader, .otherEpisodesHeader:
            if let cell = tableView.dequeueReusableCell(withIdentifier: TitleHeaderSection.identifier, for: indexPath) as? TitleHeaderSection {
                cell.labelTitle.text = rowType == .nextEpisodeHeader ? "Next episode..." : "More..."
                
                return cell
            }
        case .nextEpisode:
            if let cell = tableView.dequeueReusableCell(withIdentifier: TitleWithAccessoryCell.identifier, for: indexPath) as? TitleWithAccessoryCell {
                
                if nextEpisode == nil {
                    cell.populate(withTitle: "There's no new episodes", withAccessoryType: .none, enabled: false)
                } else {
                    cell.populate(withTitle: nextEpisode?.fullEpisodeName() ?? "", withAccessoryType: .disclosureIndicator)
                }
                
                return cell
            }
        case .seasons:
            if let cell = tableView.dequeueReusableCell(withIdentifier: TitleWithAccessoryCell.identifier, for: indexPath) as? TitleWithAccessoryCell {
                cell.populate(withTitle: "Seasons", withAccessoryType: .disclosureIndicator)
                
                return cell
            }
        }
        
        return UITableViewCell()
    }
    
}

extension ShowDetailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let rowType = DetailRows(rawValue: indexPath.row) else {
            return
        }
        
        switch rowType {
        case .nextEpisode:
            navigateToEpisodeDetail()
        case .seasons:
            navigateToSeasonList()
        default:
            return
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
        case .nextEpisodeHeader, .otherEpisodesHeader:
            return TitleHeaderSection.height
        case .nextEpisode, .seasons:
            return TitleWithAccessoryCell.height
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    private func navigateToEpisodeDetail() {
        if let nextEpisode = nextEpisode, let episodeDetailViewController = EpisodeDetailViewController.instance(withShow: show, episode: nextEpisode) {
            navigationController?.pushViewController(episodeDetailViewController, animated: true)
        }
    }
    
    private func navigateToSeasonList() {
        if let seasonsListViewController = SeasonsListViewController.instance(withShow: show) {
            navigationController?.pushViewController(seasonsListViewController, animated: true)
        }
    }
    
}
