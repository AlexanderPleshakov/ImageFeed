//
//  AuthViewController.swift
//  ImageFeed
//
//  Created by Александр Плешаков on 10.03.2024.
//

import UIKit
import ProgressHUD


final class AuthViewController: UIViewController {
    // MARK: Properties
    
    private let tokenStorage = OAuth2TokenStorage()
    weak var delegate: AuthViewControllerDelegate!
    
    // MARK: Views
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        button.setTitle("Войти", for: .normal)
        button.setTitleColor(UIColor(named: "YP Black"), for: .normal)
        button.layer.cornerRadius = 16
        button.layer.masksToBounds = true
        
        return button
    }()
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "authImage"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    // MARK: Methods
    
    @objc private func goToWebView() {
        let webView = WebViewController()
        webView.delegate = self
        navigationController?.pushViewController(webView, animated: true)
    }
}

// MARK: WebViewControllerDelegate

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

// MARK: UI

extension AuthViewController {
    private func configureNavigationBar() {
        navigationController?.navigationBar.backIndicatorImage = UIImage(named: "backwardBlackButton")
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "backwardBlackButton")
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.tintColor = UIColor(named: "YP Black")
    }
    
    private func configure() {
        view.backgroundColor = UIColor(named: "YP Black")
        configureNavigationBar()
        setupSubviews()
        loginButton.addTarget(self, action: #selector(goToWebView), for: .touchUpInside)
    }
    
    private func setupSubviews() {
        view.addSubview(loginButton)
        view.addSubview(logoImageView)
        
        setConstraints()
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            loginButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -90),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            loginButton.heightAnchor.constraint(equalToConstant: 48),
            
            logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 60),
            logoImageView.widthAnchor.constraint(equalToConstant: 60),
        ])
    }
}
