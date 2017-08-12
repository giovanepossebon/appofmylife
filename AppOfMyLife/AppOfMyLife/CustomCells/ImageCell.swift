//
//  ImageCell.swift
//  AppOfMyLife
//
//  Created by Giovane Possebon on 12/8/17.
//  Copyright © 2017 giovane. All rights reserved.
//

import UIKit

class ImageCell: UITableViewCell {

    static let nibName = "ImageCell"
    static let identifier = "ImageCell"
    static let height: CGFloat = 300
    
    @IBOutlet weak var fullImageView: UIImageView!
 
    func populate(withImageUrl imageUrl: String?) {
        if let url = imageUrl, let imageUrl = URL(string: url) {
            fullImageView.af_setImage(withURL: imageUrl)
        }
    }
}
