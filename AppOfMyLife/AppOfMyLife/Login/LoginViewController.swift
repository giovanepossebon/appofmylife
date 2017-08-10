//
//  LoginViewController.swift
//  AppOfMyLife
//
//  Created by Giovane Possebon on 9/8/17.
//  Copyright © 2017 giovane. All rights reserved.
//

import UIKit
import SafariServices

class LoginViewController: UIViewController {
    
    var presenter: LoginPresenter?
    var safariViewController: SFSafariViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = LoginPresenter(view: self)
    }
    
    @IBAction func didTouchLogin(_ sender: Any) {
        presenter?.login()
    }
    
}

extension LoginViewController: LoginView {
    
    func didStartLogin(withUrl url: URL) {
        safariViewController = SFSafariViewController(url: url)
        safariViewController.delegate = self
        safariViewController.modalPresentationStyle = .overCurrentContext
        present(safariViewController, animated: true, completion: nil)
    }
    
    func didLoginSuccessfully() {
        safariViewController?.dismiss(animated: true, completion: { 
            print("navigate")
        })
    }
    
    func errorOnLogin(error: String) {
        print(error)
    }
    
}

extension LoginViewController: SFSafariViewControllerDelegate {
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        NotificationCenter.default.removeObserver(self, name: Notification.Name("CallbackLoginNotification"), object: nil)
    }
    
}
