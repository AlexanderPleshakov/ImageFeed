//
//  ProfileLogoutServiceStub.swift
//  ImageFeedTests
//
//  Created by Александр Плешаков on 23.04.2024.
//

import Foundation
import ImageFeed

final class ProfileLogoutServiceStub: ProfileLogoutServiceProtocol {
    static var shared: any ImageFeed.ProfileLogoutServiceProtocol = ProfileLogoutServiceStub()
    
    func logout() {
        
    }
    
    
}
