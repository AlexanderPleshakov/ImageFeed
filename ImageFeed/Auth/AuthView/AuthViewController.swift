//
//  AuthViewController.swift
//  ImageFeed
//
//  Created by Александр Плешаков on 10.03.2024.
//

import UIKit


final class AuthViewController: UIViewController {
    let ShowWebViewSegueIdentifier = "ShowWebView"
    var oauth2TokenStorage = OAuth2TokenStorage()
    weak var delegate: AuthViewControllerDelegate!
    
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
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "backwardBlackButton")
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.tintColor = UIColor(named: "YP Black")
    }
}

extension AuthViewController: WebViewControllerDelegate {
    func webViewController(_ vc: WebViewController, didAuthenticateWithCode code: String) {
        OAuth2Service.shared.fetchOAuthToken(code: code) { [weak self] result in
            guard let self = self else { return }
            self.navigationController?.popViewController(animated: true)
            
            switch result {
            case .success(let bearerToken):
                self.oauth2TokenStorage.token = bearerToken
                delegate.didAuthenticate(self)
            case .failure(let error):
                print("failure with error - \(error)")
            }
        }
    }
    
    func webViewControllerDidCancel(_ vc: WebViewController) {
        navigationController?.popViewController(animated: true)
    }
}
