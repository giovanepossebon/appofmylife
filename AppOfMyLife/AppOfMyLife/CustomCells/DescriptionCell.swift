//
//  DescriptionCell.swift
//  AppOfMyLife
//
//  Created by Giovane Possebon on 12/8/17.
//  Copyright © 2017 giovane. All rights reserved.
//

import UIKit

class DescriptionCell: UITableViewCell {
    
    static let nibName = "DescriptionCell"
    static let identifier = "DescriptionCell"
    static let height: CGFloat = 100
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    func populate(withDescription description: String?) {
        descriptionLabel.text = description
    }
}
