//
//  RecommendCrew.swift
//  RunningCrew
//
//  Created by 김기훈 on 2023/08/08.
//

import Foundation

struct RecommendCrew: Codable, Hashable {
    let crews: [GuRecommendCrew]
}

struct GuRecommendCrew: Codable, Hashable {
    let id: Int
    let name, introduction, crewImgURL: String
    let memberCount: Int

    enum CodingKeys: String, CodingKey {
        case id, name, introduction
        case crewImgURL = "crewImgUrl"
        case memberCount
    }
}
