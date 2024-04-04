//
//  UserResult.swift
//  ImageFeed
//
//  Created by Александр Плешаков on 29.03.2024.
//

import Foundation

struct UserResult: Decodable {
    let profileImage: ProfileImage
}

struct ProfileImage: Decodable {
    let small: String?
    let medium: String?
    let large: String?
}
