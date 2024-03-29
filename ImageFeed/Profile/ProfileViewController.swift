//
//  ProfileViewController.swift
//  ImageFeed
//
//  Created by Александр Плешаков on 17.02.2024.
//

import UIKit

final class ProfileViewController: UIViewController {
    // MARK: Properties
    
    // For UI
    private var avatarImage: UIImage?
    
    private var userNameLabel: UILabel?
    private var userLoginLabel: UILabel?
    private var userBioLabel: UILabel?
    
    // Services
    private let bearerToken = OAuth2TokenStorage().token
    private let profileService = ProfileService.shared
    private var profileImageObserver: NSObjectProtocol?
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure(profile: profileService.profile)
        
        profileImageObserver = NotificationCenter.default.addObserver(
            forName: ProfileImageService.didChangeNotification,
            object: nil,
            queue: .main,
            using: { [weak self] _ in
                guard let self = self else { return }
                self.updateAvatar()
            })
    }
    
    // MARK: Methods
    
    
    private func updateAvatar() {
        guard
            let profileImageURL = ProfileImageService.shared.avatarURL,
            let url = URL(string: profileImageURL)
        else {
            return
        }
        
        // TODO: Обновить аватар
    }
    
    private func configure(profile: Profile?) {
        guard let profile = profile else { return }
        construct(userName: profile.name, loginName: profile.loginName, bio: profile.bio)
    }
    
    private func construct(userName: String?, loginName: String?, bio: String?) {
        // Avatar
        avatarImage = UIImage(systemName: "person.crop.circle.fill")
        let avatarImageView = UIImageView(image: avatarImage)
        avatarImageView.layer.cornerRadius = 35
        avatarImageView.tintColor = .white
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(avatarImageView)
        
        // User name
        let userNameLabel = UILabel()
        userNameLabel.font = UIFont.boldSystemFont(ofSize: 23)
        userNameLabel.text = userName
        userNameLabel.textColor = .white
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(userNameLabel)
        self.userNameLabel = userNameLabel
        
        // User login
        let userLoginLabel = UILabel()
        userLoginLabel.font = UIFont.systemFont(ofSize: 13)
        userLoginLabel.text = loginName
        userLoginLabel.textColor = UIColor(named: "YP Gray")
        userLoginLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(userLoginLabel)
        self.userLoginLabel = userLoginLabel
        
        // User description
        let userBioLabel = UILabel()
        userBioLabel.font = UIFont.systemFont(ofSize: 13)
        userBioLabel.text = bio
        userBioLabel.textColor = .white
        userBioLabel.numberOfLines = 0
        userBioLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(userBioLabel)
        self.userBioLabel = userBioLabel
        
        // Logout button
        let logoutImage = UIImage(systemName: "ipad.and.arrow.forward") ?? UIImage()
        let logoutButton = UIButton.systemButton(with: logoutImage, target: self, action: nil)
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        logoutButton.tintColor = UIColor(named: "YP Red")
        view.addSubview(logoutButton)
        
        // Constraints
        NSLayoutConstraint.activate([
            //Avatar
            avatarImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            avatarImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            avatarImageView.heightAnchor.constraint(equalToConstant: 70),
            avatarImageView.widthAnchor.constraint(equalToConstant: 70),
            
            // User Name
            userNameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 8),
            userNameLabel.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor),
            userNameLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 16),
            
            // User login
            userLoginLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 8),
            userLoginLabel.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor),
            userLoginLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 16),
            
            // User description
            userBioLabel.topAnchor.constraint(equalTo: userLoginLabel.bottomAnchor, constant: 8),
            userBioLabel.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor),
            userBioLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 16),
            
            // Logout button
            logoutButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            logoutButton.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor),
            logoutButton.heightAnchor.constraint(equalToConstant: 24),
            logoutButton.widthAnchor.constraint(equalToConstant: 24)
        ])
    }
}
