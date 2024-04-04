//
//  PhotoResult.swift
//  ImageFeed
//
//  Created by Александр Плешаков on 05.04.2024.
//

import Foundation

struct PhotoResult: Decodable {
    let id, slug: String
    let createdAt: Date?
    let width, height: Int
    let description: String?
    let altDescription: String?
    let urls: PhotoUrls
    let likes: Int
    let likedByUser: Bool
}
