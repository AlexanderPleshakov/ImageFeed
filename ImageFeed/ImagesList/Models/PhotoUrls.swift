//
//  PhotoUrls.swift
//  ImageFeed
//
//  Created by Александр Плешаков on 05.04.2024.
//

import Foundation

struct PhotoUrls: Decodable {
    let raw, full, regular, small: String
    let thumb, smallS3: String
}
