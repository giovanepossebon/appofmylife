//
//  UIViewController+Extension.swift
//  AppOfMyLife
//
//  Created by Giovane Possebon on 14/8/17.
//  Copyright © 2017 giovane. All rights reserved.
//

import UIKit
import PKHUD

extension UIViewController {
    static var name: String {
        return NSStringFromClass(classForCoder()).components(separatedBy: ".").last!
    }
    
    static func create<T: UIViewController>(storyboardName: String) -> T? {
        return UIStoryboard.createViewController(storyboardName, vcName: T.name, vcClass: T.self)
    }
    
    internal func showHUD(withMessage message: String) {
        HUD.flash(.label(message), delay: 2.0)
    }
}

