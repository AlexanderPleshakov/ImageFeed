//
//  ProfileImageServiceProtocol.swift
//  ImageFeed
//
//  Created by Александр Плешаков on 23.04.2024.
//

import Foundation

public protocol ProfileImageServiceProtocol {
    static var shared: ProfileImageServiceProtocol { get }
    static var didChangeNotification: Notification.Name { get }
    
    var avatarURL: String? { get }
    
    func clearBeforeLogout()
    func fetchProfileImageURL(username: String, completion: @escaping (Result<String, Error>) -> Void)
}
