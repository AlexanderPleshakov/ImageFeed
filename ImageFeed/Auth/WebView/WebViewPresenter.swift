//
//  WebViewPresenter.swift
//  ImageFeed
//
//  Created by Александр Плешаков on 19.04.2024.
//

import Foundation

final class WebViewPresenter: WebViewPresenterProtocol {
    var view: WebViewControllerProtocol?
    
    func viewDidLoad() {
        guard var urlComponents = URLComponents(string: Constants.unsplashAuthorizeURLString) else {
            print("urlComponents is failed")
            return
        }
        
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: Constants.accessKey),
            URLQueryItem(name: "redirect_uri", value: Constants.redirectURI),
            URLQueryItem(name: "response_type", value: "code"),
            URLQueryItem(name: "scope", value: Constants.accessScope)
        ]
        guard let url = urlComponents.url else {
            print("url is failed")
            return
        }
        
        let request = URLRequest(url: url)
        view?.load(request: request)
    }
    
    func updateProgressValue(_ value: Double) {
        let newProgress = Float(value)
        let shouldHideProgress = shouldHideProgress(for: newProgress)
        
        view?.setProgressValue(newProgress)
        view?.setProgressHidden(shouldHideProgress)
    }
    
    private func shouldHideProgress(for value: Float) -> Bool {
        return abs(value - 1.0) <= 0.0001
    }
}
