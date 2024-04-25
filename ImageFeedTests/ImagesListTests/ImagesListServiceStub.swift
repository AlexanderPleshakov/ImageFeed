//
//  ImagesListServiceStub.swift
//  ImageFeedTests
//
//  Created by Александр Плешаков on 25.04.2024.
//

import Foundation
import ImageFeed

final class ImagesListServiceStub: ImagesListServiceProtocol {
    static var didChangeNotification = Notification.Name("ImagesListServiceStub")
    
    static var shared: ImagesListServiceProtocol = ImagesListServiceStub()
    var photoId = 0
    var method = ""
    
    var photos: [ImageFeed.Photo] = [Photo(id: "0", size: CGSize.zero, createdAt: nil, welcomeDescription: nil, thumbImageURL: URL(string: "http://")!, largeImageURL: URL(string: "http://")!, isLiked: false)]
    
    
    func clearBeforeLogout() {
        photos = []
    }
    
    func changeLike(photoId: String, isLiked: Bool, _ completion: @escaping (Result<ImageFeed.Photo, any Error>) -> Void) {
        if isLiked {
            method = "DELETE"
        } else {
            method = "POST"
        }
        
        if let index = photos.firstIndex(where: { $0.id == photoId }) {
            photos[index].changeLike()
            completion(.success((photos[index])))
        }
    }
    
    func fetchPhotosNextPage() {
        photoId += 1
        let newPhoto = Photo(id: "\(photoId)", size: CGSize.zero, createdAt: nil, welcomeDescription: nil, thumbImageURL: URL(string: "http://")!, largeImageURL: URL(string: "http://")!, isLiked: false)
        photos.append(newPhoto)
    }
    
    
}
