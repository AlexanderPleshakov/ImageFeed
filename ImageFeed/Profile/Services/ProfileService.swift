//
//  ProfileService.swift
//  ImageFeed
//
//  Created by Александр Плешаков on 28.03.2024.
//

import Foundation

final class ProfileService: ProfileServiceProtocol {
    static let shared: ProfileServiceProtocol = ProfileService()
    
    private init() {}
    
    private(set) var profile: Profile?
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
        request.httpMethod = "GET"
        request.setValue("Bearer \(tokenStorage.token)", forHTTPHeaderField: "Authorization")
        
        return request
    }
    
    func clearBeforeLogout() {
        profile = nil
    }
    
    func fetchProfile(bearerToken: String, completion: @escaping (Result<Profile, Error>) -> Void) {
        assert(Thread.isMainThread)
        
        if lastToken == bearerToken {
            completion(.failure(ProfileFetchingError.repeatedRequest))
            print("Error: fetchProfile - NetworkError - repeatedRequest")
            return
        }
        
        task?.cancel()
        lastToken = bearerToken
        
        guard let request = makeRequest() else {
            completion(.failure(ProfileFetchingError.requestCreateFailure))
            print("Error: fetchProfile - NetworkError - requestCreateFailure")
            return
        }
        
        let task = URLSession.shared.objectTask(for: request) { [weak self] (result: (Result<ProfileResult, Error>)) in
            guard let self = self else { return }
            let profileImageService = ProfileImageService.shared
            
            switch result {
            case .success(let profileResult):
                let profile = Profile(profileResult: profileResult)
                self.profile = profile
                profileImageService.fetchProfileImageURL(username: profile.username) { _ in }
                completion(.success(profile))
            case .failure(let error):
                completion(.failure(error))
                print("Error: fetchProfile - NetworkError - \(error)")
            }
            
            self.task = nil
            self.lastToken = nil
        }
        self.task = task
        task.resume()
    }
}
