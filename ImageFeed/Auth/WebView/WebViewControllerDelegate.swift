//
//  WebViewControllerDelegate.swift
//  ImageFeed
//
//  Created by Александр Плешаков on 11.03.2024.
//

import UIKit
import WebKit

protocol WebViewControllerDelegate: NSObject {
    func webViewController(_ vc: WebViewController, didAuthenticateWithCode code: String)
    func webViewControllerDidCancel(_ vc: WebViewController)
}
