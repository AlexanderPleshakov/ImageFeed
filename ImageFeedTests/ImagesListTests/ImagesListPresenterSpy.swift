//
//  ImagesListPresenterSpy.swift
//  ImageFeedTests
//
//  Created by Александр Плешаков on 22.04.2024.
//

import Foundation
import ImageFeed

final class ImagesListPresenterSpy: ImagesListPresenterProtocol {
    var view: (any ImageFeed.ImagesListViewControllerProtocol)?
    var photos = [Photo]()
    
    var isViewDidLoad = false
    
    func getPhotosCount() -> Int {
        return 0
    }
    
    func getPhoto(at index: Int) -> Photo {
        return Photo(id: "0", size: CGSize.zero,
                     createdAt: "", welcomeDescription: "",
                     thumbImageURL: URL(string: "https:\\")!,
                     largeImageURL: URL(string: "https:\\")!,
                     isLiked: true)
    }
    
    func updatePhotosAndGetCounts() -> (Int, Int) {
        return (0, 0)
    }
    
    func nextPage() {
        
    }
    
    func shouldGetNextPage(for index: Int) {
        
    }
    
    func changeLike(at index: Int, _ completion: @escaping (Result<Bool, any Error>) -> Void) {
        
    }
    
    func viewDidLoad() {
        isViewDidLoad = true
    }
}
