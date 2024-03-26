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
        case createRequestError
    }
    
    func makeOAuthTokenRequest(code: String) -> URLRequest? {
        let baseURL = URL(string: "https://unsplash.com")!
        guard
            let url = URL(string: "/oauth/token"
             + "?client_id=\(Constants.accessKey)"
             + "&&client_secret=\(Constants.secretKey)"
             + "&&redirect_uri=\(Constants.redirectURI)"
             + "&&code=\(code)"
             + "&&grant_type=authorization_code",
             relativeTo: baseURL)
        else {
            assertionFailure("Failed to create url")
            return nil
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        return request
    }
    
    func fetchOAuthToken(code: String, handler: @escaping (Result<String, Error>) -> Void) {
        let request = makeOAuthTokenRequest(code: code)
        guard let request = request else {
            handler(.failure(NetworkError.createRequestError))
            return
        }
        
        let task = URLSession.shared.data(for: request) { result in
            switch result {
            case .success(let data):
                
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                do {
                    let token = try decoder.decode(OAuthTokenResponseBody.self, from: data)
                    guard let token = token.accessToken else {
                        fatalError("token is nil")
                    }
                    handler(.success(token))
                } catch {
                    handler(.failure(error))
                }
            case .failure(let error):
                handler(.failure(error))
            }
        }
        task.resume()
    }
}
