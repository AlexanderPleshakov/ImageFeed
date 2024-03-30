//
//  SplashViewController.swift
//  ImageFeed
//
//  Created by Александр Плешаков on 20.03.2024.
//

import UIKit

final class SplashViewController: UIViewController {
    
    private let showGallerySegueId = "showGallery"
    private let showAuthSegueId = "showAuthorization"
    
    private let tokenStorage = OAuth2TokenStorage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        showNextScreen()
    }
    
    private func showNextScreen() {
        if let _ = tokenStorage.tokenOrNil {
            print("Token - \(tokenStorage.token)")
            fetchProfile(token: tokenStorage.token)
        } else {
            let storyboard = UIStoryboard(name: "Main", bundle: .main)
            
            guard 
                let navigationController = storyboard.instantiateViewController(withIdentifier: "AuthNavigationController") as? UINavigationController,
                let authViewController = navigationController.viewControllers[0] as? AuthViewController
            else { return }
            
            authViewController.delegate = self
            authViewController.modalPresentationStyle = .fullScreen
            present(navigationController, animated: true)
        }
    }
    
    private func switchToTabBarController() {
        guard let window = UIApplication.shared.windows.first else {
            assertionFailure("Invalid window configuration")
            return
        }
        
        let tabBarController = UIStoryboard(name: "Main", bundle: .main)
            .instantiateViewController(withIdentifier: "TabBarViewController")
           
        window.rootViewController = tabBarController
    }
    
    private func fetchProfile(token: String) {
        let profileService = ProfileService.shared
        let profileImageService = ProfileImageService.shared
        
        profileService.fetchProfile(bearerToken: token) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let profile):
                profileImageService.fetchProfileImageURL(username: profile.username) { _ in }
                self.switchToTabBarController()
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension SplashViewController: AuthViewControllerDelegate {
    
    func didAuthenticate(_ vc: AuthViewController) {
        vc.dismiss(animated: true)
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
