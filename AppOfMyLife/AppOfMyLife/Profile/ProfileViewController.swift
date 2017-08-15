//
//  ProfileViewController.swift
//  AppOfMyLife
//
//  Created by Giovane Possebon on 13/8/17.
//  Copyright © 2017 giovane. All rights reserved.
//

import UIKit

private enum StatsRow: Int {
    case seasonsWatched
    case minutes
    case episodesWatched
    
    static let count = StatsRow.episodesWatched.hashValue + 1
    
    var title: String {
        switch self {
        case .seasonsWatched:
            return "Number of seasons watched"
        case .minutes:
            return "Total of minutes watched"
        case .episodesWatched:
            return "Number of episodes watched"
        }
    }
}

protocol ProfileView: class {
    func onProfileLoaded(userSettings: UserSettings)
    func onStatsLoaded(stats: Stats)
    func onLoadError(error: String)
}

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var imageProfile: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelUsername: UILabel!
    @IBOutlet weak var labelFollowers: UILabel!
    @IBOutlet weak var labelFriends: UILabel!
    @IBOutlet weak var labelFollowing: UILabel!

    var presenter: ProfileViewPresenter?
    
    var profile: UserSettings? {
        didSet {
            loadProfile()
        }
    }
    
    var stats: Stats? {
        didSet {
            tableView.reloadData()
            setupSocialStats()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        
        presenter = ProfilePresenter(view: self)
        presenter?.loadProfile()
    }
    
    private func setupTableView() {
        tableView.register(UINib(nibName: TitleWithDetailCell.nibName, bundle: nil), forCellReuseIdentifier: TitleWithDetailCell.identifier)
    }
    
    private func loadProfile() {
        if let user = profile?.user {
            presenter?.loadStats(fromUser: user)
        }
        
        if let avatar = profile?.user?.avatar, let url = URL(string: avatar) {
            imageProfile.af_setImage(withURL: url)
        }
        
        labelName.text = profile?.user?.name
        labelUsername.text = profile?.user?.username
    }
    
    private func setupSocialStats() {
        labelFriends.text = String(format: "%d", stats?.network?.friends ?? 0)
        labelFollowers.text = String(format: "%d", stats?.network?.followers ?? 0)
        labelFollowing.text = String(format: "%d", stats?.network?.following ?? 0)
    }
}

extension ProfileViewController: ProfileView {
    
    func onProfileLoaded(userSettings: UserSettings) {
        self.profile = userSettings
    }
    
    func onStatsLoaded(stats: Stats) {
        self.stats = stats
    }
    
    func onLoadError(error: String) {
        showHUD(withMessage: error)
    }
    
}

extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stats == nil ? 0 : StatsRow.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: TitleWithDetailCell.identifier, for: indexPath) as? TitleWithDetailCell {
            guard let statsRow = StatsRow(rawValue: indexPath.row) else {
                return UITableViewCell()
            }
            
            switch statsRow {
            case .seasonsWatched:
                cell.populate(withTitle: statsRow.title, detail: String(format: "%d", stats?.show?.watched ?? ""))
            case .episodesWatched:
                cell.populate(withTitle: statsRow.title, detail: String(format: "%d", stats?.episode?.watched ?? ""))
            case .minutes:
                cell.populate(withTitle: statsRow.title, detail: String(format: "%d", stats?.episode?.minutes ?? ""))
            }
        }
        
        return UITableViewCell()
    }
}

extension ProfileViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return TitleWithDetailCell.height
    }
    
}
