//
//  ProfileViewController.swift
//  ImageFeed
//
//  Created by Александр Плешаков on 17.02.2024.
//

import UIKit

final class ProfileViewController: UIViewController {
    
    // MARK: Outlets
    
    @IBOutlet private weak var exitButton: UIButton!
    
    // User info
    @IBOutlet private weak var userAvatarImageView: UIImageView!
    @IBOutlet private weak var userNameLabel: UILabel!
    @IBOutlet private weak var userLoginLabel: UILabel!
    @IBOutlet private weak var userDescriptionLabel: UILabel!
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
