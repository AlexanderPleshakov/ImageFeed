//
//  WebViewControllerSpy.swift
//  ImageFeedTests
//
//  Created by Александр Плешаков on 21.04.2024.
//

import UIKit
import ImageFeed

final class WebViewControllerSpy: WebViewControllerProtocol {
    var presenter: ImageFeed.WebViewPresenterProtocol?
    var loadIsCalled = false
    
    func load(request: URLRequest) {
        loadIsCalled = true
    }
    
    func setProgressValue(_ newValue: Float) {
        
    }
    
    func setProgressHidden(_ isHidden: Bool) {
        
    }
}
