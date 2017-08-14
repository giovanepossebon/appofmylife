//
//  TitleWithDetailCell.swift
//  AppOfMyLife
//
//  Created by Giovane Possebon on 13/8/17.
//  Copyright © 2017 giovane. All rights reserved.
//

import UIKit

class TitleWithDetailCell: UITableViewCell {
    
    static let nibName = "TitleWithDetailCell"
    static let identifier = "TitleWithDetailCell"
    static let height: CGFloat = 50
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    
    func populate(withTitle title: String, detail: String?) {
        titleLabel.text = title
        detailLabel.text = detail ?? ""
    }
    
}
