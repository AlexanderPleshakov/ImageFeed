//
//  WebViewPresenterProtocol.swift
//  ImageFeed
//
//  Created by Александр Плешаков on 19.04.2024.
//

import Foundation

protocol WebViewPresenterProtocol {
    var view: WebViewControllerProtocol? { get set }
    func viewDidLoad()
    func updateProgressValue(_ value: Double)
    func code(from url: URL) -> String?
}
