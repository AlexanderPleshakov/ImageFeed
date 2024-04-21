//
//  TabBarController.swift
//  ImageFeed
//
//  Created by Александр Плешаков on 30.03.2024.
//

import UIKit

final class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: "YP Black")
        tabBar.barTintColor = UIColor(named: "YP Black")
        tabBar.isTranslucent = false
        
        let presenter = ImagesListPresenter()
        let imagesListViewController = ImagesListViewController(presenter: presenter)
        presenter.view = imagesListViewController
        let profileViewController = ProfileViewController()
        
        profileViewController.tabBarItem = UITabBarItem(
            title: "",
            image: UIImage(named: "TabProfileActive"),
            selectedImage: nil
        )
        
        imagesListViewController.tabBarItem = UITabBarItem(
            title: "",
            image: UIImage(named: "TabEditorialActive"),
            selectedImage: nil)
            
        self.viewControllers  = [imagesListViewController, profileViewController]
    }
}
