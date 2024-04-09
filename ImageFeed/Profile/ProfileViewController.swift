//
//  ProfileViewController.swift
//  ImageFeed
//
//  Created by Александр Плешаков on 17.02.2024.
//

import UIKit
import Kingfisher

final class ProfileViewController: UIViewController {
    
    // MARK: Properties
    var animationLayers = [CALayer]()
    
    // For UI
    private let avatarImageView = {
        let avatarImage = UIImage(systemName: "person.crop.circle.fill")
        let avatarImageView = UIImageView(image: avatarImage)
        avatarImageView.layer.cornerRadius = 35
        avatarImageView.tintColor = .white
        avatarImageView.clipsToBounds = true
        avatarImageView.backgroundColor = UIColor(named: "YP Black")
        
        return avatarImageView
    }()
    
    private let userNameLabel: UILabel = {
        let userNameLabel = UILabel()
        userNameLabel.font = UIFont.boldSystemFont(ofSize: 23)
        userNameLabel.textColor = .white
        
        return userNameLabel
    }()
    
    private let userLoginLabel: UILabel = {
        let userLoginLabel = UILabel()
        userLoginLabel.font = UIFont.systemFont(ofSize: 13)
        userLoginLabel.textColor = UIColor(named: "YP Gray")
        
        return userLoginLabel
    }()
    
    private let userBioLabel: UILabel = {
        let userBioLabel = UILabel()
        userBioLabel.font = UIFont.systemFont(ofSize: 13)
        userBioLabel.textColor = .white
        userBioLabel.numberOfLines = 0
        
        return userBioLabel
    }()
    
    private let logoutButton: UIButton = {
        let logoutImage = UIImage(systemName: "ipad.and.arrow.forward") ?? UIImage()
        let logoutButton = UIButton.systemButton(with: logoutImage, target: nil, action: nil)
        logoutButton.tintColor = UIColor(named: "YP Red")
        
        return logoutButton
    }()
    
    private let avatarGradient = LoadingGradientView(frame: CGRect(x: 0, y: 0, width: 70, height: 70))
    // Services
    private let profileService = ProfileService.shared
    private var profileImageObserver: NSObjectProtocol?
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure(profile: profileService.profile)
        
        avatarImageView.addSubview(avatarGradient)
        
        profileImageObserver = NotificationCenter.default.addObserver(
            forName: ProfileImageService.didChangeNotification,
            object: nil,
            queue: .main,
            using: { [weak self] _ in
                guard let self = self else { return }
                self.updateAvatar()
            })
        updateAvatar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        avatarGradient.animateGradient()
    }
    
    // MARK: Methods
    
    @objc private func buttonLogoutTapped() {
        let alertPresenter = AlertPresenter(delegate: self)
        let profileLogoutService = ProfileLogoutService.shared
        let actionOk = UIAlertAction(title: "Да", style: .default) { _ in
            profileLogoutService.logout()
        }
        let actionNo = UIAlertAction(title: "Нет", style: .default)
        alertPresenter.presentTwoButtonsAlert(title: "Пока, пока!",
                                              message: "Уверены, что хотите выйти?",
                                              actionOk: actionOk, actionNo: actionNo)
        
    }
    
    private func updateAvatar() {
        guard
            let profileImageURL = ProfileImageService.shared.avatarURL,
            let url = URL(string: profileImageURL)
        else {
            return
        }
        avatarImageView.kf.setImage(
            with: url,
            placeholder: UIImage(named: "PlaceholderAvatar")) { [weak self] result in
                guard let self = self else { return }
                self.avatarGradient.removeFromSuperview()
            }
    }
    
    private func configure(profile: Profile?) {
        view.backgroundColor = UIColor(named: "YP Black")
        logoutButton.addTarget(self, action: #selector(buttonLogoutTapped), for: .touchUpInside)
        
        guard let profile = profile else { return }
        setupSubviews(userName: profile.name, loginName: profile.loginName, bio: profile.bio)
    }
    
    private func setupSubviews(userName: String?, loginName: String?, bio: String?) {
        userNameLabel.text = userName
        userLoginLabel.text = loginName
        userBioLabel.text = bio
        
        [avatarImageView, userNameLabel, userLoginLabel, userBioLabel, logoutButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        setConstrains()
    }
    
    private func setConstrains() {
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
