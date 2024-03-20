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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        showNextScreen()
    }
    
    private func showNextScreen() {
        if let token = UserDefaults.standard.string(forKey: Constants.UserDefaults.bearerTokenKey) {
            performSegue(withIdentifier: showGallerySegueId, sender: self)
        } else {
            performSegue(withIdentifier: showAuthSegueId, sender: self)
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
    }
}
