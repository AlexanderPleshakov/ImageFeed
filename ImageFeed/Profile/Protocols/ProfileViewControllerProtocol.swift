//
//  ProfileViewControllerProtocol.swift
//  ImageFeed
//
//  Created by Александр Плешаков on 22.04.2024.
//

import Foundation

protocol ProfileViewControllerProtocol: AnyObject {
    var presenter: ProfilePresenterProtocol? { get set }
}
