//
//  AlertPresenter.swift
//  ImageFeed
//
//  Created by Александр Плешаков on 29.03.2024.
//

import UIKit

final class AlertPresenter {
    
    weak var delegate: UIViewController?
    
    init(delegate: UIViewController?) {
        self.delegate = delegate
    }
    
    func presentPresentNetworkErrorAlert(title: String?, message: String?, buttonTitle: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: buttonTitle, style: .default)
        alert.addAction(action)
        delegate?.present(alert, animated: true)
    }
}
