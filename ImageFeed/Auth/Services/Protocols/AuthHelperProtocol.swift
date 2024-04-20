//
//  AuthHelperProtocol.swift
//  ImageFeed
//
//  Created by Александр Плешаков on 19.04.2024.
//

import Foundation

public protocol AuthHelperProtocol {
    func authRequest() -> URLRequest?
    func code(from url: URL) -> String?
}
