//
//  ImagesListService.swift
//  ImageFeed
//
//  Created by Александр Плешаков on 05.04.2024.
//

import Foundation

final class ImagesListService {
    static let didChangeNotification = Notification.Name("ImagesListServiceDidChange")
    static let shared = ImagesListService()
    
    private init() {}
    
    private (set) var photos: [Photo] = []
    
    private var lastLoadedPage: Int?
    
    private var tokenStorage = OAuth2TokenStorage()
    private var task: URLSessionTask?
    
    private enum NetworkError: Error {
        case indexSearchError
    }
    
    private let dateFormatter: DateFormatter? = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        return dateFormatter
    }()
    
    private let outputDateFormatter: DateFormatter? = {
        let outputDateFormatter = DateFormatter()
        outputDateFormatter.dateFormat = "d MMMM yyyy"
        outputDateFormatter.locale = Locale(identifier: "ru_RU")
        
        return outputDateFormatter
    }()
    
    private func convertToPrettyDate(from date: String?) -> String? {
        guard let stringDate = date,
           let date = dateFormatter?.date(from: stringDate) else {
            return nil
        }
        let output = outputDateFormatter?.string(from: date)
        
        return output
    }
    
    private func convertToPhoto(from photoResult: PhotoResultElement) -> Photo {
        
        let size = CGSize(width: photoResult.width, height: photoResult.height)

        let dateString = convertToPrettyDate(from: photoResult.createdAt)
        
        let photo = Photo(
            id: photoResult.id,
            size: size,
            createdAt: dateString,
            welcomeDescription: photoResult.description ?? photoResult.altDescription,
            thumbImageURL: photoResult.urls.thumb,
            largeImageURL: photoResult.urls.full,
            isLiked: photoResult.likedByUser)
        
        return photo
    }
    
    private func makeFetchPhotoRequest(page: Int) -> URLRequest? {
        guard let url = URL(string: "https://api.unsplash.com/photos?page=\(page)") else {
            fatalError("Cannot construct url")
        }
        var request = URLRequest(url: url)
        request.setValue("Bearer \(tokenStorage.token)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        
        return request
    }
    
    private func makeLikeRequest(with url: String, httpMethod: String) -> URLRequest {
        guard let url = URL(string: url) else {
            fatalError("Cannot construct url")
        }
        var request = URLRequest(url: url)
        request.setValue("Bearer \(tokenStorage.token)", forHTTPHeaderField: "Authorization")
        request.httpMethod = httpMethod
        
        return request
    }
    
    func clearBeforeLogout() {
        photos = []
    }
    
    func changeLike(photoId: String, isLiked: Bool, _ completion: @escaping (Result<Photo, Error>) -> Void) {
        let request: URLRequest
        if isLiked {
            request = makeLikeRequest(with: "https://api.unsplash.com/photos/\(photoId)/like", httpMethod: "DELETE")
        } else {
            request = makeLikeRequest(with: "https://api.unsplash.com/photos/\(photoId)/like", httpMethod: "POST")
        }
        
        let task = URLSession.shared.data(for: request) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(_):
                if let index = self.photos.firstIndex(where: { $0.id == photoId }) {
                    let oldPhoto = self.photos[index]
                    let newPhoto = Photo(id: oldPhoto.id, size: oldPhoto.size,
                                         createdAt: oldPhoto.createdAt,
                                         welcomeDescription: oldPhoto.welcomeDescription,
                                         thumbImageURL: oldPhoto.thumbImageURL,
                                         largeImageURL: oldPhoto.largeImageURL,
                                         isLiked: !oldPhoto.isLiked)
                    self.photos[index] = newPhoto
                    completion(.success((newPhoto)))
                } else {
                    completion(.failure(NetworkError.indexSearchError))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
        task.resume()
    }

    
    func fetchPhotosNextPage() {
        
        if task != nil {
            print("Repeated fetch photos request ")
            return
        }
        
        task?.cancel()
        let page = (lastLoadedPage ?? 0) + 1
        lastLoadedPage = page
        guard let request = makeFetchPhotoRequest(page: page) else {
            print("Cannot construct request")
            return
        }
        let task = URLSession.shared.objectTask(for: request) { [weak self] (result: (Result<PhotoResult, Error>)) in
            guard let self = self else { return }
            
            switch result {
            case .success(let photoResult):
                var photos = [Photo]()
                photoResult[..<(photoResult.count - 2)].forEach {
                    let photo = self.convertToPhoto(from: $0)
                    photos.append(photo)
                }
                self.photos += photos
                NotificationCenter.default.post(name: ImagesListService.didChangeNotification, object: self)
            case .failure(let error):
                print("Error: fetchPhotosNextPage - SomeError - \(error)")
            }
            self.task = nil
        }
        self.task = task
        task.resume()
    }
}
