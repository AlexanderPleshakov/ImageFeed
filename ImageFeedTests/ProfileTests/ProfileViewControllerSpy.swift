//
//  ProfileViewControllerSpy.swift
//  ImageFeedTests
//
//  Created by Александр Плешаков on 23.04.2024.
//

import Foundation
import ImageFeed

//final class ProfileViewControllerSpy: ProfileViewControllerProtocol {
//    var presenter: ProfilePresenterProtocol?
//    var isAvatarSet = false
//    var isConfigure = false
//    var isAvatarImageUpdated = false
//    
//    func setAvatar(url: URL) {
//        isAvatarSet = true
//    }
//    
//    func configure(for profile: Profile) {
//        isConfigure = true
//    }
//    
//    func updateAvatarImage() {
//        isAvatarImageUpdated = true
//    }
//}

final class ProfileViewControllerSpy: ProfileViewControllerProtocol {
    var presenter: ProfilePresenterProtocol?
    var isAvatarSet = false
    var isConfigure = false
    var isAvatarImageUpdated = false

    func setAvatar(url: URL) {
        isAvatarSet = true
    }

    func configure(for profile: Profile) {
        isConfigure = true
    }

    func updateAvatarImage() {
        isAvatarImageUpdated = true
    }
}
