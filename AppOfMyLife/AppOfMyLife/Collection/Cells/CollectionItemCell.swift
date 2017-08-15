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
    @IBOutlet weak var episodeName: UILabel!
 
    override func awakeFromNib() {
        super.awakeFromNib()
        setupDropShadow()
        resetUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        resetUI()
    }
    
    private func resetUI() {
        imageThumb.image = nil
        episodeName.text = nil
    }
    
    
    private func setupDropShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 2, height: 4)
        layer.shadowOpacity = 1
        layer.shadowRadius = 1.0
        clipsToBounds = false
        layer.masksToBounds = false
    }
    
    func populate(withShow show: Show) {
        episodeName.text = show.title
        if let tvdbId = show.ids?.tvdb, let url = URL(string: ShowBannerStyle.portrait(id: tvdbId, variation: 1).url) {
            imageThumb.af_setImage(withURL: url)
        }
    }
    
    func populate(withCollection collection: ShowCollection) {
        episodeName.text = collection.show?.title
        if let tvdbId = collection.show?.ids?.tvdb, let url = URL(string: ShowBannerStyle.portrait(id: tvdbId, variation: 1).url) {
            imageThumb.af_setImage(withURL: url)
        }
    }
    
}
