//
//  AuthViewController.swift
//  ImageFeed
//
//  Created by Александр Плешаков on 10.03.2024.
//

import UIKit


final class AuthViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
    }
    
    private func configureNavigationBar() {
        navigationController?.navigationBar.backIndicatorImage = UIImage(named: "backwardBlackButton")
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "nav_back_button")
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.tintColor = UIColor(named: "YP Black")
    }
}
