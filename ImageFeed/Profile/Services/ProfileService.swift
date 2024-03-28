//
//  ProfileService.swift
//  ImageFeed
//
//  Created by Александр Плешаков on 28.03.2024.
//

import Foundation

final class ProfileService {
    
    private let tokenStorage = OAuth2TokenStorage()
    private var lastToken: String?
    private var task: URLSessionTask?
    
    private enum ProfileFetchingError: Error {
        case incorrectURL, requestCreateFailure, decodeFailure,
        repeatedRequest
    }
    
    func fetchProfile(bearerToken: String, completion: @escaping (Result<ProfileResult, Error>) -> Void) {
        assert(Thread.isMainThread)
        
        guard let url = URL(string: "https://api.unsplash.com/me") else {
            completion(.failure(ProfileFetchingError.incorrectURL))
            return
        }
        
        guard lastToken != bearerToken else {
            completion(.failure(ProfileFetchingError.repeatedRequest))
            return
        }
        
        task?.cancel()
        lastToken = bearerToken
        
        var request = URLRequest(url: url)
        request.setValue("Bearer \(tokenStorage.token)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.data(for: request) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                do {
                    let profileResult = try decoder.decode(ProfileResult.self, from: data)
                    completion(.success(profileResult))
                } catch {
                    completion(.failure(ProfileFetchingError.decodeFailure))
                }
            case .failure(let error):
                completion(.failure(error))
            }
            
            self.task = nil
            self.lastToken = nil
        }
        self.task = task
        task.resume()
    }
}
