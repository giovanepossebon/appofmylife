//
//  LoginPresenter.swift
//  AppOfMyLife
//
//  Created by Giovane Possebon on 9/8/17.
//  Copyright © 2017 giovane. All rights reserved.
//

import Foundation
import SafariServices

protocol LoginViewPresenter {
    init(view: LoginView)
    func login()
}

class LoginPresenter: LoginViewPresenter {
    unowned let view: LoginView
    
    required init(view: LoginView) {
        self.view = view
    }
    
    func login() {
        guard let loginUrl = TraktAPI.URLs.loginURL else {
            return
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(didLoginSuccessfully(notification:)), name: NSNotification.Name("CallbackLoginNotification"), object: nil)
        
        view.didStartLogin(withUrl: loginUrl)
    }
    
    @objc func didLoginSuccessfully(notification: Notification) {
        if let url = notification.object as? URL {
            if let code = url.absoluteString.components(separatedBy: "code=").last {
                loginWithCode(code: code)
            }
        }
    }
    
    private func loginWithCode(code: String) {
        let request = LoginRequest(code: code,
                                   clientId: TraktAPI.clientId,
                                   clientSecret: TraktAPI.clientSecret,
                                   redirectUri: TraktAPI.redirectUri,
                                   grantType: TraktAPI.grantType)
        
        LoginService.getToken(request: request, callback: { response in
            switch response.result {
            case .success:
                guard let auth = response.data, let token = auth.accessToken else {
                    return
                }
                
                UserSession.shared.accessToken = token
                self.view.didLoginSuccessfully()
            case .error(message: let error):
                self.view.errorOnLogin(error: error)
            }
        })
    }
}
