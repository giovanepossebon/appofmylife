//
//  TitleWithAccessoryCell.swift
//  AppOfMyLife
//
//  Created by Giovane Possebon on 12/8/17.
//  Copyright © 2017 giovane. All rights reserved.
//

import UIKit

class TitleWithAccessoryCell: UITableViewCell {
    
    static let nibName = "TitleWithAccessoryCell"
    static let identifier = "TitleWithAccessoryCell"
    static let height: CGFloat = 44
    
    @IBOutlet weak var labelTitle: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: animated)
    }
    
    func populate(withTitle title: String,
                  withAccessoryType type: UITableViewCellAccessoryType,
                  enabled: Bool = true) {
        labelTitle.text = title
        accessoryType = type
        isUserInteractionEnabled = enabled
    }
    
}
