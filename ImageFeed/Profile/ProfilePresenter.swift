//
//  ProfilePresenter.swift
//  ImageFeed
//
//  Created by Александр Плешаков on 22.04.2024.
//

import Foundation

final class ProfilePresenter: ProfilePresenterProtocol {
    weak var view: ProfileViewControllerProtocol?
    private var logoutService: ProfileLogoutServiceProtocol
    private var profileService: ProfileServiceProtocol
    private var profileImageService: ProfileImageServiceProtocol
    
    init(view: ProfileViewControllerProtocol? = nil,
         logoutService: ProfileLogoutServiceProtocol = ProfileLogoutService.shared,
         profileService: ProfileServiceProtocol = ProfileService.shared,
         profileImageService: ProfileImageServiceProtocol = ProfileImageService.shared) {
        self.view = view
        self.logoutService = logoutService
        self.profileService = profileService
        self.profileImageService = profileImageService
    }
    
    func doLogoutAction() {
        logoutService.logout()
    }
    
    func updateAvatar(){
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
