//
//  LoginView.swift
//  AppOfMyLife
//
//  Created by Giovane Possebon on 9/8/17.
//  Copyright © 2017 giovane. All rights reserved.
//

import Foundation

protocol LoginView: class {
    func didStartLogin(withUrl url: URL)
    func didLoginSuccessfully()
    func errorOnLogin(error: String)
}
