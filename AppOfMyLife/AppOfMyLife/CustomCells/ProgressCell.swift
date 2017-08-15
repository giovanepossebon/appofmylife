//
//  ProgressCell.swift
//  AppOfMyLife
//
//  Created by Giovane Possebon on 12/8/17.
//  Copyright © 2017 giovane. All rights reserved.
//

import UIKit

class ProgressCell: UITableViewCell {
    
    static let nibName = "ProgressCell"
    static let identifier = "ProgressCell"
    static let height: CGFloat = 65
    
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var statusProgressView: UIProgressView!
    
    func populate(withProgress progress: ShowProgress) {
        if let completed = progress.completed, let aired = progress.aired {
            statusLabel.text = "\(completed)/\(aired)"
            statusProgressView.setProgress(Float(completed) / Float(aired), animated: true)
        }
    }
}
