//
//  WebViewControllerProtocol.swift
//  ImageFeed
//
//  Created by Александр Плешаков on 19.04.2024.
//

import Foundation

protocol WebViewControllerProtocol: AnyObject {
    var presenter: WebViewPresenterProtocol? {get set}
}
