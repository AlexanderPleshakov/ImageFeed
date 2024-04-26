//
//  AuthHelperFake.swift
//  ImageFeedTests
//
//  Created by Александр Плешаков on 21.04.2024.
//

import Foundation
import ImageFeed

final class AuthHelperFake: AuthHelperProtocol {
    func authRequest() -> URLRequest? {
        return URLRequest(url: URL(string: "https://")!)
    }
    
    func code(from url: URL) -> String? {
        return nil
    }
    
    
}
