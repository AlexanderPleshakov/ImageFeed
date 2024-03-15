//
//  0Auth2Service.swift
//  ImageFeed
//
//  Created by Александр Плешаков on 15.03.2024.
//

import UIKit

final class OAuth2Service {
    static let shared = OAuth2Service()
    
    private init () {}
    
    private enum NetworkError: Error {
        case codeError
    }
    
    func makeOAuthTokenRequest(code: String) -> URLRequest {
        guard var urlComponents = URLComponents(string: "https://unsplash.com/oauth/token") else {
            fatalError("Ошибка создания urlComponents")
        }
        
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: Constants.accessKey),
            URLQueryItem(name: "client_secret", value: Constants.secretKey),
            URLQueryItem(name: "redirect_uri", value: Constants.redirectURI),
            URLQueryItem(name: "code", value: code),
            URLQueryItem(name: "client_id", value: "authorization_code")
        ]
        
        guard let url = urlComponents.url else {
            fatalError("Ошибка создания url")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        return request
    }
    
    func fetchOAuthToken(code: String, handler: @escaping (Result<String, Error>) -> Void) {
        let request = makeOAuthTokenRequest(code: code)
        
        let task = URLSession.shared.data(for: request) { result in
            switch result {
            case .success(let data):
                
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                guard let token = try? decoder.decode(OAuthTokenResponseBody.self, from: data),
                      let accessToken = token.accessToken
                else {
                    fatalError("Token is nil")
                }
                handler(.success(accessToken))
                
            case .failure(let error):
                handler(.failure(error))
            }
        }
    }
}
