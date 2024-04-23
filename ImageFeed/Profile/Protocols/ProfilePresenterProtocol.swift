//
//  ProfilePresenterProtocol.swift
//  ImageFeed
//
//  Created by Александр Плешаков on 22.04.2024.
//

import Foundation

protocol ProfilePresenterProtocol {
    var view: ProfileViewControllerProtocol? { get set }
    func doLogoutAction()
}
