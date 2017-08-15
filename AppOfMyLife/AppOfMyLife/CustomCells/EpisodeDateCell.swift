//
//  EpisodeDateCell.swift
//  AppOfMyLife
//
//  Created by Giovane Possebon on 13/8/17.
//  Copyright © 2017 giovane. All rights reserved.
//

import UIKit

class EpisodeDateCell: UITableViewCell {
    
    static let nibName = "EpisodeDateCell"
    static let identifier = "EpisodeDateCell"
    static let height: CGFloat = 72
    
    @IBOutlet weak var labelDateAndMonth: UILabel!
    @IBOutlet weak var labelYear: UILabel!
    @IBOutlet weak var labelRuntime: UILabel!
    
    func populate(withEpisode episode: Episode) {
        if let timestamp = episode.firstAired {
            let time = Date.dateFromISOString(string: timestamp)
            labelDateAndMonth.text = time.ISOStringFromDate(withDateFormat: .dayMonthAndHour)
            labelYear.text = time.ISOStringFromDate(withDateFormat: .year)
            
            if let runtime = episode.runtime {
               labelRuntime.text = "\(runtime) min"
            }
            
        }
    }
    
}


