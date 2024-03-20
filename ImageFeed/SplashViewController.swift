//
//  SplashViewController.swift
//  ImageFeed
//
//  Created by Александр Плешаков on 20.03.2024.
//

import UIKit

final class SplashViewController: UIViewController {
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        showNextScreen()
    }
    
    private func showNextScreen() {
        if let token = UserDefaults.standard.string(forKey: Constants.UserDefaults.bearerTokenKey) {
            performSegue(withIdentifier: "showGallery", sender: self)
        } else {
            performSegue(withIdentifier: "showAuthorization", sender: self)
        }
    }
}
