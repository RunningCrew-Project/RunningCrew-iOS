//
//  User.swift
//  RunningCrew
//
//  Created by 김기훈 on 2023/08/07.
//

import Foundation

struct User: Codable {
    let id: Int
    let email, name, nickname: String
    let imgURL: String
    let loginType, sex, birthday: String
    let height, weight: Int

    enum CodingKeys: String, CodingKey {
        case id, email, name, nickname
        case imgURL = "imgUrl"
        case loginType, sex, birthday, height, weight
    }
}
