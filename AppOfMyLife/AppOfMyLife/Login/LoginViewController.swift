//
//  LoginViewController.swift
//  AppOfMyLife
//
//  Created by Giovane Possebon on 9/8/17.
//  Copyright © 2017 giovane. All rights reserved.
//

import UIKit
import SafariServices

protocol LoginView: class {
    func didStartLogin(withUrl url: URL)
    func didLoginSuccessfully()
    func errorOnLogin(error: String)
}

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
            self.navigateToHomeViewController()
        })
    }
    
    func errorOnLogin(error: String) {
        print(error)
    }
    
    private func navigateToHomeViewController() {
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        if let mainTabBarController = mainStoryBoard.instantiateViewController(withIdentifier: "MainTabBarController") as? UITabBarController {
            present(mainTabBarController, animated: true, completion: nil)
        }
    }
}

extension LoginViewController: SFSafariViewControllerDelegate {
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        NotificationCenter.default.removeObserver(self, name: Notification.Name("CallbackLoginNotification"), object: nil)
    }
    
}
