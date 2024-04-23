//
//  ProfilePresenter.swift
//  ImageFeed
//
//  Created by Александр Плешаков on 22.04.2024.
//

import Foundation

final class ProfilePresenter: ProfilePresenterProtocol {
    var view: ProfileViewControllerProtocol?
    var logoutService = ProfileLogoutService.shared
    var profileService = ProfileService.shared
    
    func doLogoutAction() {
        logoutService.logout()
    }
    
    
}
