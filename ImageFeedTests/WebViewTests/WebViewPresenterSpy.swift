//
//  WebViewPresenterSpy.swift
//  ImageFeedTests
//
//  Created by Александр Плешаков on 20.04.2024.
//

import ImageFeed
import Foundation

final class WebViewPresenterSpy: WebViewPresenterProtocol {
    var viewDidLoadCalled: Bool = false
    var view: WebViewControllerProtocol?
    
    func viewDidLoad() {
        viewDidLoadCalled = true
    }
    
    func updateProgressValue(_ value: Double) {
        viewDidLoadCalled = true
    }
    
    func shouldHideProgress(for value: Float) -> Bool {
        return true
    }
    
    func code(from url: URL) -> String? {
        return nil
    }
}
