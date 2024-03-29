//
//  AuthViewController.swift
//  ImageFeed
//
//  Created by Александр Плешаков on 10.03.2024.
//

import UIKit
import ProgressHUD


final class AuthViewController: UIViewController {
    private let showWebViewSegueIdentifier = "ShowWebView"
    private let tokenStorage = OAuth2TokenStorage()
    weak var delegate: AuthViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == showWebViewSegueIdentifier {
            guard let webViewController = segue.destination as? WebViewController else {
                fatalError("Failed to prepare for \(showWebViewSegueIdentifier)")
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
        UIBlockingProgressHUD.show()
        OAuth2Service.shared.fetchOAuthToken(code: code) { [weak self] result in
            guard let self = self else { return }
            self.navigationController?.popViewController(animated: true)
            
            switch result {
            case .success(let bearerToken):
                self.tokenStorage.token = bearerToken
                delegate.didAuthenticate(self)
                print("Authenticated")
            case .failure(let error):
                print("failure with error - \(error)")
                let alertPresenter = AlertPresenter(delegate: self)
                alertPresenter.presentPresentNetworkErrorAlert(
                    title: "Что-то пошло не так(",
                    message: "Не удалось войти в систему",
                    buttonTitle: "Ok")
            }
            UIBlockingProgressHUD.dismiss()
        }
    }
    
    func webViewControllerDidCancel(_ vc: WebViewController) {
        navigationController?.popViewController(animated: true)
    }
}
