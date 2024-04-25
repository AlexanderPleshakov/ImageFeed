//
//  ImagesListViewControllerSpy.swift
//  ImageFeedTests
//
//  Created by Александр Плешаков on 22.04.2024.
//

import Foundation
import ImageFeed

final class ImagesListViewControllerSpy: ImagesListViewControllerProtocol {
    var isShowedProgressHUD = false
    var isCalledUpdateTable = false
    
    func showProgressHUD() {
        isShowedProgressHUD = true
    }
    
    func dismissProgressHUD() {
        
    }
    
    func updateTableViewAnimated() {
        isCalledUpdateTable = true
    }
    
    
}
