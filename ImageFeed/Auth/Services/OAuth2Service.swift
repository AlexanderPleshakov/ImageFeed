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
        let baseURL = URL(string: "https://unsplash.com")!
         let url = URL(string: "/oauth/token"
             + "?client_id=\(Constants.accessKey)"         //
             + "&&client_secret=\(Constants.secretKey)"
             + "&&redirect_uri=\(Constants.redirectURI)"
             + "&&code=\(code)"
             + "&&grant_type=authorization_code",
             relativeTo: baseURL)!
        print("https://unsplash.com/oauth/token"
              + "?client_id=\(Constants.accessKey)"         //
              + "&&client_secret=\(Constants.secretKey)"
              + "&&redirect_uri=\(Constants.redirectURI)"
              + "&&code=\(code)"
              + "&&grant_type=authorization_code")
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
                print("failure in fetching, error - \(error)")
                handler(.failure(error))
            }
        }
        task.resume()
    }
}
