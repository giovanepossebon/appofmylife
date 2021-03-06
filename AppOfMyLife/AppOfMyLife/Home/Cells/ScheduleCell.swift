//
//  NextEpisodeCell.swift
//  AppOfMyLife
//
//  Created by Giovane Possebon on 10/8/17.
//  Copyright © 2017 giovane. All rights reserved.
//

import UIKit
import AlamofireImage

class ScheduleCell: UITableViewCell {
    
    static let identifier = "ScheduleCell"
    static let nibName = "ScheduleCell"
    static let height: CGFloat = 135
    
    @IBOutlet weak var imgBackground: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelSubtitle: UILabel!
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var labelHour: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    func populate(withSchedule schedule: Schedule) {
        labelTitle.text = schedule.episode?.title
        labelSubtitle.text = schedule.show?.title
        
        if let timestamp = schedule.firstAired {
            let time = Date.dateFromISOString(string: timestamp)
            labelDate.text = time.ISOStringFromDate(withDateFormat: .dayAndMonth)
            labelHour.text = time.ISOStringFromDate(withDateFormat: .hour)
        }
        
        if let tvdbId = schedule.show?.ids?.tvdb, let url = URL(string: ShowBannerStyle.landscape(id: tvdbId, variation: 2).url) {
            imgBackground.af_setImage(withURL: url)
        }
        
    }
}
