//
//  ProfileResult.swift
//  ImageFeed
//
//  Created by Александр Плешаков on 28.03.2024.
//

import Foundation

struct ProfileResult: Decodable {
    let username: String
    let firstName: String
    let lastName: String?
    let bio: String?
}
