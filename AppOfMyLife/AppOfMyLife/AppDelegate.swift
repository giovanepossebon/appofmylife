//
//  AppDelegate.swift
//  AppOfMyLife
//
//  Created by Giovane Possebon on 8/8/17.
//  Copyright © 2017 giovane. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        
        if let sourceApplication = options[.sourceApplication] {
            if (String(describing: sourceApplication) == "com.apple.SafariViewService") {
                NotificationCenter.default.post(name: Notification.Name("CallbackLoginNotification"), object: url)
                return true
            }
        }
        
        return false
    }

}

