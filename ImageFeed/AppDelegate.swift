//
//  AppDelegate.swift
//  ImageFeed
//
//  Created by Александр Плешаков on 06.02.2024.
//

import UIKit
import ProgressHUD

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        ProgressHUD.colorHUD = UIColor(red: 255, green: 255, blue: 255, alpha: 0.5)
        ProgressHUD.colorAnimation = UIColor(named: "YP Black") ?? .lightGray
        ProgressHUD.animationType = .activityIndicator
        ProgressHUD.mediaSize = 51
        ProgressHUD.marginSize = 13
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        let sceneConfiguration = UISceneConfiguration(
            name: "Main",
            sessionRole: connectingSceneSession.role
        )
        sceneConfiguration.delegateClass = SceneDelegate.self

        return sceneConfiguration
    }
}

