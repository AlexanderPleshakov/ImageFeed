//
//  ProfileViewControllerProtocol.swift
//  ImageFeed
//
//  Created by Александр Плешаков on 22.04.2024.
//

import Foundation

public protocol ProfileViewControllerProtocol: AnyObject {
    var presenter: ProfilePresenterProtocol? { get set }
    
    func setAvatar(url: URL)
    func configure(for profile: Profile)
    func updateAvatarImage()
}
