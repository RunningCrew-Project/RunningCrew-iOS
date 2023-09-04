//
//  SignUpUser.swift
//  RunningCrew
//
//  Created by 김기훈 on 2023/08/08.
//

import Foundation

struct SignUpUser: Codable {
    let name: String
    let nickname: String
    let dongId: Int
    let birthday: String
    let sex: String
    let height: Int
    let weight: Int
}
