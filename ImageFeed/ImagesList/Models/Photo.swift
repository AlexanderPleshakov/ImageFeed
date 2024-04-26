//
//  Photo.swift
//  ImageFeed
//
//  Created by Александр Плешаков on 05.04.2024.
//

import Foundation

public struct Photo {
    public private(set) var id: String
     var size: CGSize
    var createdAt: String?
    var welcomeDescription: String?
    var thumbImageURL: URL
    var largeImageURL: URL
    private(set) var isLiked: Bool
    
    public init(id: String, size: CGSize, createdAt: String?, welcomeDescription: String?, thumbImageURL: URL, largeImageURL: URL, isLiked: Bool) {
        self.id = id
        self.size = size
        self.createdAt = createdAt
        self.welcomeDescription = welcomeDescription
        self.thumbImageURL = thumbImageURL
        self.largeImageURL = largeImageURL
        self.isLiked = isLiked
    }
    
    public mutating func changeLike() {
        isLiked = !isLiked
    }
}
