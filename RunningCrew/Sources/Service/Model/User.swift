//
//  User.swift
//  RunningCrew
//
//  Created by 김기훈 on 2023/08/07.
//

import Foundation

struct User: Codable {
    let id: Int
    let email, name, nickname, imgURL: String
    let loginType, phoneNumber, dongArea, sex: String
    let birthday: String
    let height, weight: Int

    enum CodingKeys: String, CodingKey {
        case id, email, name, nickname
        case imgURL = "imgUrl"
        case loginType, phoneNumber, dongArea, sex, birthday, height, weight
    }
}
