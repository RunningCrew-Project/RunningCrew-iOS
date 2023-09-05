//
//  Notification.swift
//  RunningCrew
//
//  Created by 김기훈 on 2023/08/23.
//

import Foundation

struct Notification: Codable {
    let content: [NotificationContent]
    let size, number, numberOfElements: Int
    let first, last, hasNext: Bool
}

struct NotificationContent: Codable, Hashable {
    let id: Int
    let createdDate, title, content, type: String
    let crewName: String
    let crewImgURL: String
    let referenceID: Int

    enum CodingKeys: String, CodingKey {
        case id, createdDate, title, content, type, crewName
        case crewImgURL = "crewImgUrl"
        case referenceID = "referenceId"
    }
}
