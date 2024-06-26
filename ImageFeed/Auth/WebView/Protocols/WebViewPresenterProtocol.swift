//
//  WebViewPresenterProtocol.swift
//  ImageFeed
//
//  Created by Александр Плешаков on 19.04.2024.
//

import Foundation

public protocol WebViewPresenterProtocol {
    var view: WebViewControllerProtocol? { get set }
    func viewDidLoad()
    func updateProgressValue(_ value: Double)
    func shouldHideProgress(for value: Float) -> Bool
    func code(from url: URL) -> String?
}
