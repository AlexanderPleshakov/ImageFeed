//
//  OAuth2TokenStorage.swift
//  ImageFeed
//
//  Created by Александр Плешаков on 16.03.2024.
//

import UIKit

final class OAuth2TokenStorage {
    var token: String {
        get {
            guard let token = UserDefaults.standard.string(forKey: "bearerToken") else {
                fatalError("Bearer token isn't string")
            }
            return token
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "bearerToken")
        }
    }
}
