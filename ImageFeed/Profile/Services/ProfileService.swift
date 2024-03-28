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
    
    private func makeRequest() -> URLRequest? {
        guard let url = URL(string: "https://api.unsplash.com/me") else {
            assertionFailure("Cannot construct url")
            return nil
        }
        
        var request = URLRequest(url: url)
        request.setValue("Bearer \(tokenStorage.token)", forHTTPHeaderField: "Authorization")
        
        return request
    }
    
    func fetchProfile(bearerToken: String, completion: @escaping (Result<Profile, Error>) -> Void) {
        assert(Thread.isMainThread)
        
        guard lastToken != bearerToken else {
            completion(.failure(ProfileFetchingError.repeatedRequest))
            return
        }
        
        task?.cancel()
        lastToken = bearerToken
        
        guard let request = makeRequest() else {
            completion(.failure(ProfileFetchingError.requestCreateFailure))
            return
        }
        
        let task = URLSession.shared.data(for: request) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                do {
                    let profileResult = try decoder.decode(ProfileResult.self, from: data)
                    let profile = Profile(profileResult: profileResult)
                    completion(.success(profile))
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
