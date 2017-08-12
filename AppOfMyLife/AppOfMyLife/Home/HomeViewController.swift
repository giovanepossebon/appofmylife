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
        tableView.register(UINib(nibName: NextEpisodeCell.nibName, bundle: nil), forCellReuseIdentifier: NextEpisodeCell.identifier)
        tableView.register(UINib(nibName: NextEpisodeSection.nibName, bundle: nil), forCellReuseIdentifier: NextEpisodeSection.identifier)
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
        print(error)
    }
}

// MARK: TableViewDatSource

extension HomeViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return schedule?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: NextEpisodeCell.identifier, for: indexPath) as? NextEpisodeCell {
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
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return NextEpisodeCell.height
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return NextEpisodeSection.height
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let cell = tableView.dequeueReusableCell(withIdentifier: NextEpisodeSection.identifier) as? NextEpisodeSection {
            cell.labelTitle.text = "In the next episode..."
            
            return cell
        }
        
        return UIView()
    }
    
}
