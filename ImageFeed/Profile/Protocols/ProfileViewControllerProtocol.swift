//
//  ProfileViewControllerProtocol.swift
//  ImageFeed
//
//  Created by Александр Плешаков on 22.04.2024.
//

import UIKit

protocol ProfileViewControllerProtocol: AnyObject {
    var presenter: ProfilePresenterProtocol? { get set }
    
    func setAvatar(url: URL)
    func configure(for profile: Profile)
    func updateAvatarImage()
}
