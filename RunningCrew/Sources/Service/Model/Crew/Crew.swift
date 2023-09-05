//
//  Crew.swift
//  RunningCrew
//
//  Created by 김기훈 on 2023/08/07.
//

import Foundation

struct Crew: Codable, Hashable {
    let id: Int
    let createdDate, name, introduction, crewImgURL: String
    let dong: String
    let memberCount: Int
    let joinApply, joinQuestion: Bool

    enum CodingKeys: String, CodingKey {
        case id, createdDate, name, introduction
        case crewImgURL = "crewImgUrl"
        case dong, memberCount, joinApply, joinQuestion
    }
}
