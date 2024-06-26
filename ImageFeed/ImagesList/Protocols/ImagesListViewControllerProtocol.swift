//
//  ImagesListViewControllerProtocol.swift
//  ImageFeed
//
//  Created by Александр Плешаков on 21.04.2024.
//

import Foundation

public protocol ImagesListViewControllerProtocol: AnyObject {
    func showProgressHUD()
    func dismissProgressHUD()
    func updateTableViewAnimated()
}
