//
//  AuthViewControllerDelegate.swift
//  ImageFeed
//
//  Created by Александр Плешаков on 20.03.2024.
//

import UIKit

protocol AuthViewControllerDelegate: NSObject {
    func didAuthenticate(_ vc: AuthViewController)
}
