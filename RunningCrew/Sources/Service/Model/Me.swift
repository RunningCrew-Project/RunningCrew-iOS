//
//  Me.swift
//  RunningCrew
//
//  Created by 김기훈 on 2023/08/07.
//

import Foundation

struct Me: Codable {
    let id: Int
    let email, name, nickname, imgURL: String

    enum CodingKeys: String, CodingKey {
        case id, email, name, nickname
        case imgURL = "imgUrl"
    }
}
