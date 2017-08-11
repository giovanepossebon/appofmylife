//
//  NextEpisodeCell.swift
//  AppOfMyLife
//
//  Created by Giovane Possebon on 10/8/17.
//  Copyright © 2017 giovane. All rights reserved.
//

import UIKit

class NextEpisodeCell: UITableViewCell {
    
    static let identifier = "NextEpisodeCell"
    static let nibName = "NextEpisodeCell"
    static let height: CGFloat = 135.0
    
    @IBOutlet weak var imgBackground: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelSubtitle: UILabel!

}
