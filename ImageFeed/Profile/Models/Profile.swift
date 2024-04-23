//
//  Profile.swift
//  ImageFeed
//
//  Created by Александр Плешаков on 28.03.2024.
//

import Foundation

public struct Profile {
    
    let name: String
    let username: String
    let loginName: String
    let bio: String
    
    init(profileResult: ProfileResult) {
        name = profileResult.firstName + " " + (profileResult.lastName ?? "")
        username = profileResult.username
        loginName = "@\(profileResult.username)"
        bio = profileResult.bio ?? ""
    }
}
