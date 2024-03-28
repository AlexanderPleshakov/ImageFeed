//
//  ProfileService.swift
//  ImageFeed
//
//  Created by Александр Плешаков on 28.03.2024.
//

import Foundation

final class ProfileService {
    
    private let tokenStorage = OAuth2TokenStorage()
    
    private enum ProfileFetchingError: Error {
        case incorrectURL, requestCreateFailure, decodeFailure
    }
    
    func fetchProfile(bearerToken: String, completion: @escaping (Result<ProfileResult, Error>) -> Void) {
        guard let url = URL(string: "https://api.unsplash.com/me") else {
            completion(.failure(ProfileFetchingError.incorrectURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.setValue("Bearer \(tokenStorage.token)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.data(for: request) { result in
            
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
        }
        task.resume()
    }
}
