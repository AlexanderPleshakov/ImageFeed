//
//  ImagesListService.swift
//  ImageFeed
//
//  Created by Александр Плешаков on 05.04.2024.
//

import Foundation

final class ImagesListService {
    static let didChangeNotification = Notification.Name("ImagesListServiceDidChange")
    
    private (set) var photos: [Photo] = []
    
    private var lastLoadedPage: Int?
    
    private var tokenStorage = OAuth2TokenStorage()
    private var task: URLSessionTask?
    
    private enum FetchingPhotoListError: Error {
        case invalidPhotoListRequest, decodePhotoFailure,
        repeatedRequest
    }
    
    private func convertToPrettyDate(from date: String?) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

        guard let stringDate = date,
           let date = dateFormatter.date(from: stringDate) else {
            return nil
        }
        
        let outputDateFormatter = DateFormatter()
        outputDateFormatter.dateFormat = "d MMMM yyyy"
        
        let output = outputDateFormatter.string(from: date)
        
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
    
    private func makeRequest(page: Int) -> URLRequest? {
        guard let url = URL(string: "https://api.unsplash.com/photos?page=\(page)") else {
            fatalError("Cannot construct url")
        }
        var request = URLRequest(url: url)
        request.setValue("Bearer \(tokenStorage.token)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        
        return request
    }
    
    func fetchPhotosNextPage(completion: @escaping (Result<[Photo], Error>) -> Void) {
        
        if task != nil {
            completion(.failure(FetchingPhotoListError.repeatedRequest))
            return
        }
        
        task?.cancel()
        
        let page = (lastLoadedPage ?? 0) + 1
        guard let request = makeRequest(page: page) else {
            completion(.failure(FetchingPhotoListError.invalidPhotoListRequest))
            return
        }
        let task = URLSession.shared.objectTask(for: request) { [weak self] (result: (Result<PhotoResult, Error>)) in
            guard let self = self else { return }
            
            switch result {
            case .success(let photoResult):
                var photos = [Photo]()
                photoResult.forEach {
                    let photo = self.convertToPhoto(from: $0)
                    photos.append(photo)
                }
                self.photos += photos
                completion(.success(photos))
                NotificationCenter.default.post(name: ImagesListService.didChangeNotification, object: self)
            case .failure(let error):
                completion(.failure(error))
            }
            self.task = nil
        }
        self.task = task
        task.resume()
    }
}
