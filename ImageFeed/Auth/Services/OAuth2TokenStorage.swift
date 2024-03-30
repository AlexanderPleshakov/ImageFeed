//
//  OAuth2TokenStorage.swift
//  ImageFeed
//
//  Created by Александр Плешаков on 16.03.2024.
//

import UIKit
import SwiftKeychainWrapper

final class OAuth2TokenStorage {
    var token: String {
        get {
            guard let retrievedString = KeychainWrapper.standard.string(forKey: Constants.UserDefaults.bearerTokenKey) else {
                fatalError("Bearer token is nil")
            }
            return retrievedString
        }
        set {
            let saveSuccessful: Bool = KeychainWrapper.standard.set(newValue, forKey: Constants.UserDefaults.bearerTokenKey)
            
            guard saveSuccessful else {
                fatalError("Saving key error")
            }
        }
    }
    
    var tokenOrNil: String? {
        get {
            return KeychainWrapper.standard.string(forKey: Constants.UserDefaults.bearerTokenKey)
        }
    }
}
