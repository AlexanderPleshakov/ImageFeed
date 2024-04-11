//
//  Photo.swift
//  ImageFeed
//
//  Created by Александр Плешаков on 05.04.2024.
//

import Foundation

struct Photo {
    let id: String
    let size: CGSize
    let createdAt: String?
    let welcomeDescription: String?
    let thumbImageURL: URL
    let largeImageURL: URL
    let isLiked: Bool
}
