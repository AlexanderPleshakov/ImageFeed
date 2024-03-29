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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        showNextScreen()
    }
    
    private func showNextScreen() {
        if let _ = UserDefaults.standard.string(forKey: Constants.UserDefaults.bearerTokenKey) {
            print("Token - \(tokenStorage.token)")
            fetchProfile(token: tokenStorage.token)
        } else {
            performSegue(withIdentifier: showAuthSegueId, sender: self)
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
                UIBlockingProgressHUD.dismiss()
                profileImageService.fetchProfileImageURL(username: profile.username) { _ in }
                self.switchToTabBarController()
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension SplashViewController: AuthViewControllerDelegate {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == showAuthSegueId {
            let navigationController = segue.destination as? UINavigationController
            guard let authViewController = navigationController?.viewControllers[0] as? AuthViewController 
            else {
                assertionFailure("Failed to prepare for \(showAuthSegueId)")
                return
            }
            authViewController.delegate = self
        } else {
            super.prepare(for: segue, sender: sender)
        }
    }
    
    func didAuthenticate(_ vc: AuthViewController) {
        vc.dismiss(animated: true)
        //fetchProfile(token: tokenStorage.token)
    }
}
