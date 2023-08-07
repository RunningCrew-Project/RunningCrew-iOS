//
//  SocialLogIn.swift
//  RunningCrew
//
//  Created by 김기훈 on 2023/07/24.
//

import Foundation

struct SocialLogInRequest: Encodable {
    let fcmToken: String
    let accessToken: String
    let idToken: String
    let origin: String
}

struct SocialLogInResponse: Decodable {
    let accessToken: String
    let refreshToken: String
    let initData: Bool
    
    enum CodingKeys: String, CodingKey {
        case accessToken
        case refreshToken
        case initData
    }
}
