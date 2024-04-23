//
//  ProfileImageServiceStub.swift
//  ImageFeedTests
//
//  Created by Александр Плешаков on 23.04.2024.
//

import Foundation
import ImageFeed

final class ProfileImageServiceStub: ProfileImageServiceProtocol {
    static var shared: any ImageFeed.ProfileImageServiceProtocol = ProfileImageServiceStub()
    
    static let didChangeNotification = Notification.Name(rawValue: "ProfileImageProviderDidChangeStub")
    
    var avatarURL: String?
    
    func clearBeforeLogout() {
        
    }
    
    func fetchProfileImageURL(username: String, completion: @escaping (Result<String, any Error>) -> Void) {
        avatarURL = "http://"
    }
}
