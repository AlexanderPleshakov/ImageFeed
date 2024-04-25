//
//  ImagesLiseViewControllerFake.swift
//  ImageFeedTests
//
//  Created by Александр Плешаков on 25.04.2024.
//

import Foundation
import ImageFeed

final class ImagesListViewControllerFake: ImagesListViewControllerProtocol {
    var presenter: ImagesListPresenterProtocol!
    func showProgressHUD() {
        
    }
    
    func dismissProgressHUD() {
        
    }
    
    func updateTableViewAnimated() {
        let (oldCount, newCount) = presenter.updatePhotosAndGetCounts()
    }
    
    
}
