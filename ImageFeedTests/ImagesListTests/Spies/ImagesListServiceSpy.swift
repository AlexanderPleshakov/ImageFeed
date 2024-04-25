//
//  ImagesListServiceSpy.swift
//  ImageFeedTests
//
//  Created by Александр Плешаков on 25.04.2024.
//

import Foundation
import ImageFeed

final class ImagesListServiceSpy: ImagesListServiceProtocol {
    static var didChangeNotification = Notification.Name("ImagesListServiceSpy")
    
    static var shared: ImagesListServiceProtocol = ImagesListServiceSpy()
    
    var photos: [ImageFeed.Photo] = [Photo]()
    var method = ""
    
    func clearBeforeLogout() {
        
    }
    
    func changeLike(photoId: String, isLiked: Bool, _ completion: @escaping (Result<ImageFeed.Photo, any Error>) -> Void) {
        if isLiked {
            method = "DELETE"
        } else {
            method = "POST"
        }
    }
    
    func fetchPhotosNextPage() {
        
    }
    
    
}
