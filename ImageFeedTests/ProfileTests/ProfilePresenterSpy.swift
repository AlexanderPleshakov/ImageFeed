//
//  ProfilePresenterSpy.swift
//  ImageFeedTests
//
//  Created by Александр Плешаков on 24.04.2024.
//

import Foundation
import ImageFeed

final class ProfilePresenterSpy: ProfilePresenterProtocol {
    var view: (any ImageFeed.ProfileViewControllerProtocol)?
    var isAvatarUpdated = false
    var isViewDidLoad = false
    
    func doLogoutAction() {}
    
    func updateAvatar() {
        isAvatarUpdated = true
    }
    
    func viewDidLoad() {
        isViewDidLoad = true
    }
    
    
}
