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
            print("Error: fetchOAuthToken - NetworkError - ivalidRequest")
            return
        }
        
        let task = URLSession.shared.objectTask(for: request) { [weak self] (result: Result<OAuthTokenResponseBody, Error>) in
            guard let self = self else { return }
            switch result {
            case .success(let token):
                
                guard let token = token.accessToken else {
                    fatalError("token is nil")
                }
                handler(.success(token))
            case .failure(let error):
                handler(.failure(error))
                print("Error: fetchOAuthToken - NetworkError - \(error.localizedDescription)")
            }
            self.task = nil
            self.lastCode = nil
        }
        self.task = task
        task.resume()
    }
}
