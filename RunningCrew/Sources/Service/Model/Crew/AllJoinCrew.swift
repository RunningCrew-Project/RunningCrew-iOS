//
//  AllJoinCrew.swift
//  RunningCrew
//
//  Created by 김기훈 on 2023/08/13.
//

import Foundation

struct AllJoinCrew: Codable {
    let crews: [Crew]
}

// struct Crew: Codable {
//    let id: Int
//    let name, crewImgURL: String
//
//    enum CodingKeys: String, CodingKey {
//        case id, name
//        case crewImgURL = "crewImgUrl"
//    }
// }
