//
//  ImagesListCellDelegate.swift
//  ImageFeed
//
//  Created by Александр Плешаков on 08.04.2024.
//

import Foundation

protocol ImagesListCellDelegate: AnyObject {
    func imageListCellDidTapLike(_ cell: ImagesListCell)
}
