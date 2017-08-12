//
//  CollectionItemCell.swift
//  AppOfMyLife
//
//  Created by Giovane Possebon on 12/8/17.
//  Copyright © 2017 giovane. All rights reserved.
//

import UIKit

class CollectionItemCell: UICollectionViewCell {
    
    static let nibName = "CollectionItemCell"
    static let identifier = "CollectionItemCell"
    static let height: CGFloat = 250

    @IBOutlet weak var imageThumb: UIImageView!
 
    override func awakeFromNib() {
        super.awakeFromNib()
        setupDropShadow()
    }
    
    private func setupDropShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 2, height: 4)
        layer.shadowOpacity = 1
        layer.shadowRadius = 1.0
        clipsToBounds = false
        layer.masksToBounds = false
    }
    
    func populate(withCollection collection: Collection) {
        if let tvdbId = collection.show?.ids?.tvdb, let url = URL(string: ShowBannerStyle.portrait(id: tvdbId).url) {
            imageThumb.af_setImage(withURL: url)
        }
    }
    
}
