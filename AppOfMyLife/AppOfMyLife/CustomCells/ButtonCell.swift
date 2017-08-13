//
//  ButtonCell.swift
//  AppOfMyLife
//
//  Created by Giovane Possebon on 13/8/17.
//  Copyright © 2017 giovane. All rights reserved.
//

import UIKit

protocol ButtonCellDelegate {
    func onButtonTouched()
}

class ButtonCell: UITableViewCell {
    
    var delegate: ButtonCellDelegate?
    
    static let nibName = "ButtonCell"
    static let identifier = "ButtonCell"
    static let height: CGFloat = 78
    
    @IBOutlet weak var button: UIButton!
    
    func populate(withTitle title: String, color: UIColor) {
        button.setTitle(title, for: .normal)
        button.backgroundColor = color
    }
    
    @IBAction func didTouchButton(_ sender: Any) {
        delegate?.onButtonTouched()
    }

}
