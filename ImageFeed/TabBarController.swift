//
//  TabBarController.swift
//  ImageFeed
//
//  Created by Александр Плешаков on 30.03.2024.
//

import UIKit

final class TabBarController: UITabBarController {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let imagesListViewController = ImagesListViewController()
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
