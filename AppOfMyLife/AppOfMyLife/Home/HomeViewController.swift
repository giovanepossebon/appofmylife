//
//  HomeViewController.swift
//  AppOfMyLife
//
//  Created by Giovane Possebon on 10/8/17.
//  Copyright © 2017 giovane. All rights reserved.
//

import UIKit

protocol HomeView: class {
    func onScheduleLoaded(schedule: [Schedule])
    func onLoadFailed(error: String)
}

class HomeViewController: UITableViewController {
    
    var presenter: HomeViewPresenter?
    var schedule: [Schedule]? {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = HomePresenter(view: self)
        
        setupTableView()
        loadSchedule()
    }
    
    private func setupTableView() {
        tableView.register(UINib(nibName: ScheduleCell.nibName, bundle: nil), forCellReuseIdentifier: ScheduleCell.identifier)
        tableView.register(UINib(nibName: TitleHeaderSection.nibName, bundle: nil), forCellReuseIdentifier: TitleHeaderSection.identifier)
        tableView.separatorStyle = .none
    }
    
    private func loadSchedule() {
        presenter?.loadSchedule()
    }
    
}

extension HomeViewController: HomeView {
 
    func onScheduleLoaded(schedule: [Schedule]) {
        self.schedule = schedule
    }
    
    func onLoadFailed(error: String) {
        showHUD(withMessage: error)
    }
}

// MARK: TableViewDatSource

extension HomeViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return schedule?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: ScheduleCell.identifier, for: indexPath) as? ScheduleCell {
            if let item = schedule?[indexPath.row] {
                cell.populate(withSchedule: item)
                
                return cell
            }
        }
        
        return UITableViewCell()
    }
    
}

// MARK: TableViewDelegate

extension HomeViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let item = schedule?[indexPath.row], let show = item.show, let episode = item.episode else {
            return
        }
        
        if let episodeDetailViewController = EpisodeDetailViewController.instance(withShow: show, episode: episode) {
            navigationController?.pushViewController(episodeDetailViewController, animated: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ScheduleCell.height
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return TitleHeaderSection.height
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let cell = tableView.dequeueReusableCell(withIdentifier: TitleHeaderSection.identifier) as? TitleHeaderSection {
            cell.labelTitle.text = "In the next episode..."
            
            return cell
        }
        
        return UIView()
    }
    
}
