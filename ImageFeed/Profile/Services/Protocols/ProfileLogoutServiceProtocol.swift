//
//  ProfileLogoutServiceProtocol.swift
//  ImageFeed
//
//  Created by Александр Плешаков on 23.04.2024.
//

import Foundation

public protocol ProfileLogoutServiceProtocol {
    static var shared: ProfileLogoutServiceProtocol { get }
    func logout()
}
