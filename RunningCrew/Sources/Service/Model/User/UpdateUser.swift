//
//  UpdateUser.swift
//  RunningCrew
//
//  Created by 김기훈 on 2023/08/13.
//

import Foundation

struct UpdateUser: Codable {
    let name, nickname: String
    let dongID: Int
    let file: Data
    let sex, birthday: String
    let height, weight: Int

    enum CodingKeys: String, CodingKey {
        case name, nickname
        case dongID = "dongId"
        case file, sex, birthday, height, weight
    }
}
