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
    var profileImageService = ProfileImageService.shared
    
    func doLogoutAction() {
        logoutService.logout()
    }
    
    func updateAvatarURL(){
        guard
            let profileImageURL = profileImageService.avatarURL,
            let url = URL(string: profileImageURL)
        else {
            return
        }
        view?.setAvatar(url: url)
    }
    
    func viewDidLoad() {
        guard let profile = profileService.profile else {
            print("profile is nil")
            return
        }
        
        view?.configure(for: profile)
        
        addNotification()
    }
    
    private func addNotification() {
        NotificationCenter.default.addObserver(
            forName: ProfileImageService.didChangeNotification,
            object: nil,
            queue: .main,
            using: { [weak self] _ in
                guard let self = self else { return }
                self.view?.updateAvatarImage()
            })
        view?.updateAvatarImage()
    }
}
