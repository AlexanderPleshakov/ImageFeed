//
//  AuthHelperDummy.swift
//  ImageFeedTests
//
//  Created by Александр Плешаков on 21.04.2024.
//

import Foundation
import ImageFeed

final class AuthHelperDummy: AuthHelperProtocol {
    func authRequest() -> URLRequest? { return nil }
    func code(from url: URL) -> String? { return nil }
}
