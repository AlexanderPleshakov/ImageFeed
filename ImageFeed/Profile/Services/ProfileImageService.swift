//
//  ProfileImageService.swift
//  ImageFeed
//
//  Created by Александр Плешаков on 29.03.2024.
//

import UIKit

final class ProfileImageService {
    static let shared = ProfileImageService()
    
    static let didChangeNotification = Notification.Name(rawValue: "ProfileImageProviderDidChange")
    
    private(set) var avatarURL: String?
    private var task: URLSessionTask?
    private var username: String?
    
    private init() {}
    
    private enum FetchingImageError: Error {
        case invalidImageRequest, imageIsNil, decodeImageFailure,
        repeatedRequest
    }
    
    private func makeRequest(username: String) -> URLRequest? {
        
        guard let url = URL(string: "https://api.unsplash.com/users/\(username)") else {
            print("cannot construct url for fetching image")
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(OAuth2TokenStorage().token)", forHTTPHeaderField: "Authorization")
        
        return request
    }
    
    func fetchProfileImageURL(username: String, completion: @escaping (Result<String, Error>) -> Void) {
        
        if self.username == username {
            completion(.failure(FetchingImageError.repeatedRequest))
            print("Error: fetchProfileImageURL - FetchingImageError - repeatedRequest")
            return
        }
        
        self.username = username
        task?.cancel()
        
        guard let request = makeRequest(username: username) else {
            completion(.failure(FetchingImageError.invalidImageRequest))
            print("Error: fetchProfileImageURL - FetchingImageError - invalidImageRequest")
            return
        }
        
        let task = URLSession.shared.objectTask(for: request) { [weak self] (result:(Result<UserResult, Error>)) in
            assert(Thread.isMainThread)
            
            guard let self = self else { return }
            
            switch result{
            case .success(let userResult):
                guard let avatarURL = userResult.profileImage.large else {
                    completion(.failure(FetchingImageError.imageIsNil))
                    print("Error: fetchProfileImageURL - FetchingImageError - imageIsNil")
                    return
                }
                
                self.avatarURL = avatarURL
                completion(.success(avatarURL))
                NotificationCenter.default.post(name: ProfileImageService.didChangeNotification,
                                                object: self,
                                                userInfo: ["URL": avatarURL])
            case .failure(let error):
                completion(.failure(error))
                print("Error: fetchProfileImageURL - NetworkError - \(error)")
            }
            self.task = nil
            self.username = nil
        }
        
        self.task = task
        task.resume()
    }
}
