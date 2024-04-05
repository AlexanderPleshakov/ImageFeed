//
//  PhotoResult.swift
//  ImageFeed
//
//  Created by Александр Плешаков on 05.04.2024.
//

import Foundation

struct PhotoResultElement: Decodable {
    let id: String
    let width, height: Int
    let createdAt: String?
    let description, altDescription: String?
    let urls: PhotoUrls
    let likes: Int
    let likedByUser: Bool
}

typealias PhotoResult = [PhotoResultElement]
