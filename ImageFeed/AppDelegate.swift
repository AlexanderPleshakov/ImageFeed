//
//  AppDelegate.swift
//  ImageFeed
//
//  Created by Александр Плешаков on 06.02.2024.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        #warning("delete clear method")
        clearAppData()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {

        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func clearAppData() {
        UserDefaults.standard.removeObject(forKey: Constants.UserDefaults.bearerTokenKey)
        // Определение путей кеша и временной директории
        if let cacheDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first,
           let tmpDirectory = FileManager.default.temporaryDirectory.path as? String {
            
            // Удаление файлов из кеша
            do {
                let cacheURLs = try FileManager.default.contentsOfDirectory(at: cacheDirectory, includingPropertiesForKeys: nil, options: [])
                for fileURL in cacheURLs {
                    try FileManager.default.removeItem(at: fileURL)
                }
            } catch {
                print("Ошибка при удалении файлов из кеша: \(error.localizedDescription)")
            }
            
            // Удаление файлов из временной директории
            do {
                let tmpURLs = try FileManager.default.contentsOfDirectory(atPath: tmpDirectory)
                for file in tmpURLs {
                    let filePath = (tmpDirectory as NSString).appendingPathComponent(file)
                    try FileManager.default.removeItem(atPath: filePath)
                }
            } catch {
                print("Ошибка при удалении файлов из временной директории: \(error.localizedDescription)")
            }
        }
    }

}

