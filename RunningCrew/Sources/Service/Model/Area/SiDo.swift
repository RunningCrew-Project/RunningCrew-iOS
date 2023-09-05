//
//  SiDo.swift
//  RunningCrew
//
//  Created by 김기훈 on 2023/08/31.
//

struct SiDo: Codable {
    let areas: [Area]
}

struct Area: Codable {
    let id: Int
    let name: String
}
