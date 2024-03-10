//
//  AuthViewController.swift
//  ImageFeed
//
//  Created by Александр Плешаков on 10.03.2024.
//

import UIKit


final class AuthViewController: UIViewController {
    let ShowWebViewSegueIdentifier = "ShowWebView"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == ShowWebViewSegueIdentifier {
            guard let webViewController = segue.destination as? WebViewController else {
                fatalError("Failed to prepare for \(ShowWebViewSegueIdentifier)")
            }
            webViewController.delegate = self
        } else {
            super.prepare(for: segue, sender: sender)
        }
        
    }
    
    private func configureNavigationBar() {
        navigationController?.navigationBar.backIndicatorImage = UIImage(named: "backwardBlackButton")
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "nav_back_button")
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.tintColor = UIColor(named: "YP Black")
    }
}

extension AuthViewController: WebViewControllerDelegate {
    func webViewController(_ vc: WebViewController, didAuthenticateWithCode code: String) {
        
    }
    
    func webViewControllerDidCancel(_ vc: WebViewController) {
        dismiss(animated: true)
    }
    
    
}
