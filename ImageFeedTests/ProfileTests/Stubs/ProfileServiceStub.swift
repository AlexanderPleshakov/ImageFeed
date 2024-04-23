//
//  ProfileServiceStub.swift
//  ImageFeedTests
//
//  Created by Александр Плешаков on 23.04.2024.
//

import Foundation
import ImageFeed

final class ProfileServiceStub: ProfileServiceProtocol {
    static var shared: any ImageFeed.ProfileServiceProtocol = ProfileServiceStub()
    
    var profile: ImageFeed.Profile?
    
    func clearBeforeLogout() {
        
    }
    
    func fetchProfile(bearerToken: String, completion: @escaping (Result<ImageFeed.Profile, any Error>) -> Void) {
        profile = Profile()
    }
    
    
}
