//
//  ProfileImageService.swift
//  ImageFeed
//
//  Created by Александр Плешаков on 29.03.2024.
//

import UIKit

final class ProfileImageService {
    static let shared = ProfileImageService()
    
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
        request.setValue("Bearer \(OAuth2TokenStorage().token)", forHTTPHeaderField: "Authorization")
        
        return request
    }
    
    func fetchProfileImageURL(username: String, completion: @escaping (Result<String, Error>) -> Void) {
        print("-- Start fetching user image --")
        
        if self.username == username {
            completion(.failure(FetchingImageError.repeatedRequest))
            return
        }
        
        self.username = username
        task?.cancel()
        
        guard let request = makeRequest(username: username) else {
            completion(.failure(FetchingImageError.invalidImageRequest))
            return
        }
        
        let task = URLSession.shared.data(for: request) { [weak self] result in
            assert(Thread.isMainThread)
            
            guard let self = self else { return }
            
            switch result{
            case .success(let data):
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                do {
                    let userResult = try decoder.decode(UserResult.self, from: data)
                    
                    guard let avatarURL = userResult.profileImage.small else {
                        completion(.failure(FetchingImageError.imageIsNil))
                        return
                    }
                    
                    self.avatarURL = avatarURL
                    print(avatarURL)
                    completion(.success(avatarURL))
                } catch {
                    completion(.failure(FetchingImageError.decodeImageFailure))
                }
            case .failure(let error):
                completion(.failure(error))
            }
            self.task = nil
            self.username = nil
            print("-- Finish fetching user image --")
        }
        
        self.task = task
        task.resume()
    }
}
