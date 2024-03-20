//
//  Constants.swift
//  ImageFeed
//
//  Created by Александр Плешаков on 10.03.2024.
//

import Foundation

enum Constants {
    static let accessKey = "KEofjj-QLCo5Ux6HcfLoc21tc6hbJbSfy93fv-1WaQ8"
    static let secretKey = "FDV9nQuHHqeQsxxWD38iQ7fEdk8cLxYP6Sf60HB6Q6w"
    static let redirectURI = "urn:ietf:wg:oauth:2.0:oob"
    
    static let accessScope = "public+read_user+write_likes"
    static let defaultBaseURL = URL(string: "https://api.unsplash.com")!
    
    static let unsplashAuthorizeURLString = "https://unsplash.com/oauth/authorize"
    
    enum UserDefaults {
        static let bearerTokenKey = "bearerToken"
    }
}
