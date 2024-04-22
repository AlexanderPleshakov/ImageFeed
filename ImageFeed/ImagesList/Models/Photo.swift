//
//  Photo.swift
//  ImageFeed
//
//  Created by Александр Плешаков on 05.04.2024.
//

import Foundation

public struct Photo {
    let id: String
    let size: CGSize
    let createdAt: String?
    let welcomeDescription: String?
    let thumbImageURL: URL
    let largeImageURL: URL
    let isLiked: Bool
    
    public init(id: String, size: CGSize, createdAt: String?, welcomeDescription: String?, thumbImageURL: URL, largeImageURL: URL, isLiked: Bool) {
        self.id = id
        self.size = size
        self.createdAt = createdAt
        self.welcomeDescription = welcomeDescription
        self.thumbImageURL = thumbImageURL
        self.largeImageURL = largeImageURL
        self.isLiked = isLiked
    }
}
