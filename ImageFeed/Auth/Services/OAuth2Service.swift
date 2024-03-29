//
//  0Auth2Service.swift
//  ImageFeed
//
//  Created by Александр Плешаков on 15.03.2024.
//

import UIKit

final class OAuth2Service {
    static let shared = OAuth2Service()
    
    private var task: URLSessionTask?
    private var lastCode: String?
    
    private init () {}
    
    private enum NetworkError: Error {
        case codeError
        case invalidRequest, equalAuthCodes, differentAuthCodes
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
        assert(Thread.isMainThread)
        print("-- Start fetching token --")
        
        guard lastCode != code else {
            handler(.failure(NetworkError.differentAuthCodes))
            return
        }
        
        task?.cancel()
        lastCode = code
        
        
        guard let request = makeOAuthTokenRequest(code: code) else {
            handler(.failure(NetworkError.invalidRequest))
            return
        }
        
        let task = URLSession.shared.data(for: request) { [weak self] result in
            guard let self = self else { return }
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
            self.task = nil
            self.lastCode = nil
        }
        self.task = task
        task.resume()
    }
}
