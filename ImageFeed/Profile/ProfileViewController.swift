//
//  ProfileViewController.swift
//  ImageFeed
//
//  Created by Александр Плешаков on 17.02.2024.
//

import UIKit

final class ProfileViewController: UIViewController {
    // MARK: Properties
    
    var avatarImage: UIImage?
    var userName: String?
    var userLogin: String?
    var userDescription: String?
    
    var userNameLabel: UILabel?
    var userLoginLabel: UILabel?
    var userDescriptionLabel: UILabel?
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    // MARK: Methods
    
    private func configure() {
        // Avatar
        avatarImage = UIImage(systemName: "person.crop.circle.fill")
        let avatarImageView = UIImageView(image: avatarImage)
        avatarImageView.layer.cornerRadius = 35
        avatarImageView.tintColor = .white
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(avatarImageView)
        
        // User name
        userName = "Екатерина Новикова"
        let userNameLabel = UILabel()
        userNameLabel.font = UIFont.boldSystemFont(ofSize: 23)
        userNameLabel.text = userName
        userNameLabel.textColor = .white
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(userNameLabel)
        self.userNameLabel = userNameLabel
        
        // User login
        userLogin = "@ecaterina_nov"
        let userLoginLabel = UILabel()
        userLoginLabel.font = UIFont.systemFont(ofSize: 13)
        userLoginLabel.text = userLogin
        userLoginLabel.textColor = UIColor(named: "YP Gray")
        userLoginLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(userLoginLabel)
        self.userLoginLabel = userLoginLabel
        
        // User description
        userDescription = "Hello, world!"
        let userDescriptionLabel = UILabel()
        userDescriptionLabel.font = UIFont.systemFont(ofSize: 13)
        userDescriptionLabel.text = userDescription
        userDescriptionLabel.textColor = .white
        userDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(userDescriptionLabel)
        self.userDescriptionLabel = userDescriptionLabel
        
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
            
            // User login
            userLoginLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 8),
            userLoginLabel.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor),
            
            // User description
            userDescriptionLabel.topAnchor.constraint(equalTo: userLoginLabel.bottomAnchor, constant: 8),
            userDescriptionLabel.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor),
            
            // Logout button
            logoutButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            logoutButton.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor),
            logoutButton.heightAnchor.constraint(equalToConstant: 24),
            logoutButton.widthAnchor.constraint(equalToConstant: 24)
        ])
    }
}
