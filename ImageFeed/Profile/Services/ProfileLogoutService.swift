//
//  ProfileLogoutService.swift
//  ImageFeed
//
//  Created by Александр Плешаков on 08.04.2024.
//

import Foundation
import WebKit
import SwiftKeychainWrapper

final class ProfileLogoutService {
    static let shared = ProfileLogoutService()
    
    private let profileImageService = ProfileImageService.shared
    private let profileService = ProfileService.shared
    private let imagesListService = ImagesListService.shared
    
    private init() { }
    
    func logout() {
        cleanCookies()
        KeychainWrapper.standard.remove(forKey: KeychainWrapper.Key(rawValue: Constants.Keys.bearerTokenKey))
        profileImageService.clearBeforeLogout()
        profileService.clearBeforeLogout()
        imagesListService.clearBeforeLogout()
    }
    
    private func cleanCookies() {
        HTTPCookieStorage.shared.removeCookies(since: Date.distantPast)
        WKWebsiteDataStore.default().fetchDataRecords(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes()) { records in
            records.forEach { record in
                WKWebsiteDataStore.default().removeData(ofTypes: record.dataTypes, for: [record], completionHandler: {})
            }
        }
    }
}

