//
//  OAuthTokenResponseBody.swift
//  ImageFeed
//
//  Created by Александр Плешаков on 16.03.2024.
//

import Foundation

struct OAuthTokenResponseBody: Decodable {
    let accessToken: String?
}
