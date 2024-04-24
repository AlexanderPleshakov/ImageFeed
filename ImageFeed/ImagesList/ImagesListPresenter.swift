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
    
    func viewDidLoad() {
        NotificationCenter.default.addObserver(
            forName: ImagesListService.didChangeNotification,
            object: nil,
            queue: .main) { [weak self] _ in
                guard let self = self else { return }
                self.view?.updateTableViewAnimated()
        }
        
        if getPhotosCount() != 0 {
            view?.updateTableViewAnimated()
        }
        
        nextPage()
    }
    
    func getPhotosCount() -> Int {
        photos.count
    }
    
    func getPhoto(at index: Int) -> Photo? {
        guard index <= photos.count - 1 else {
            return nil
        }
        return photos[index]
    }
    
    func updatePhotosAndGetCounts() -> (Int, Int) {
        let oldCount = getPhotosCount()
        photos = imagesListService.photos
        let newCount = getPhotosCount()
        return (oldCount, newCount)
    }
    
    func nextPage() {
        imagesListService.fetchPhotosNextPage()
    }
    
    func shouldGetNextPage(for index: Int) {
        let testMode =  ProcessInfo.processInfo.arguments.contains("testMode")
        if index == getPhotosCount() - 1 && !testMode {
            imagesListService.fetchPhotosNextPage()
        }
    }
    
    func changeLike(at index: Int, _ completion: @escaping (Result<Bool, any Error>) -> Void) {
        let photo = photos[index]
        
        view?.showProgressHUD()
        imagesListService.changeLike(photoId: photo.id, isLiked: photo.isLiked) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let newPhoto):
                self.photos[index] = newPhoto
                completion(.success(newPhoto.isLiked))
            case .failure(let error):
                print(error)
                completion(.failure(error))
            }
        }
    }
}
