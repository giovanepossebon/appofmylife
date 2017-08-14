//
//  UIStoryboard+Extension.swift
//  AppOfMyLife
//
//  Created by Giovane Possebon on 14/8/17.
//  Copyright © 2017 giovane. All rights reserved.
//

import UIKit

extension UIStoryboard {
    static func createViewController<VCType>(_ storyboardName: String, vcName: String, vcClass: VCType.Type) -> VCType? {
        if let vcClass = vcClass as? UIViewController.Type {
            let bundle = Bundle(for: vcClass)
            let storyboard = UIStoryboard(name: storyboardName, bundle: bundle)
            return storyboard.instantiateViewController(withIdentifier: vcName) as? VCType
        } else {
            return nil
        }
    }
}
