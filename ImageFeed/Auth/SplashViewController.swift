//
//  SplashViewController.swift
//  ImageFeed
//
//  Created by Александр Плешаков on 20.03.2024.
//

import UIKit

final class SplashViewController: UIViewController {
    // MARK: Properties
    
    private let tokenStorage = OAuth2TokenStorage()
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        showNextScreen()
    }
    
    // MARK: Methods
    
    private func showNextScreen() {
        if let token = tokenStorage.tokenOrNil {
            fetchProfile(token: token)
        } else {
            let authViewController = AuthViewController()
            let navigationController = UINavigationController(rootViewController: authViewController)
            
            navigationController.modalPresentationStyle = .fullScreen
            authViewController.delegate = self
            present(navigationController, animated: true)
        }
    }
    
    private func switchToTabBarController() {
        guard let window = UIApplication.shared.windows.first else {
            assertionFailure("Invalid window configuration")
            return
        }
        
        let tabBarController = TabBarController()
           
        window.rootViewController = tabBarController
    }
    
    private func fetchProfile(token: String) {
        let profileService = ProfileService.shared
        
        profileService.fetchProfile(bearerToken: token) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(_):
                self.switchToTabBarController()
            case .failure(let error):
                print(error)
            }
        }
    }
}

// MARK: AuthViewControllerDelegate

extension SplashViewController: AuthViewControllerDelegate {
    
    func didAuthenticate(_ vc: AuthViewController) {
        vc.dismiss(animated: false)
    }
}

extension SplashViewController {
    private func configure() {
        view.backgroundColor = UIColor(named: "YP Black")
        
        let logoImage = UIImage(named: "LaunchScreenLogo")
        let imageView = UIImageView(image: logoImage)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 77),
            imageView.widthAnchor.constraint(equalToConstant: 75)
        ])
    }
}
