//
//  ImagesListPresenter.swift
//  ImageFeed
//
//  Created by Александр Плешаков on 21.04.2024.
//

import Foundation

final class ImagesListPresenter: ImagesListPresenterProtocol {
    weak var view: ImagesListViewControllerProtocol?
    private let imagesListService = ImagesListService.shared
    private var photos = [Photo]()
    
    func photosCount() -> Int {
        photos.count
    }
    
    func getPhoto(at index: Int) -> Photo {
        photos[index]
    }
    
    func updatePhotosAndGetCounts() -> (Int, Int) {
        let oldCount = photosCount()
        photos = imagesListService.photos
        let newCount = photosCount()
        return (oldCount, newCount)
    }
    
    func nextPage() {
        
    }
    
    func shouldGetNextPage(for index: Int) {
        <#code#>
    }
    
    func changeLike(at index: Int, _ completion: @escaping (Result<Bool, any Error>) -> Void) {
        <#code#>
    }
}
