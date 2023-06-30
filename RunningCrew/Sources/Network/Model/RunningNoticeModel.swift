//
//  RunningNoticeModel.swift
//  RunningCrew
//
//  Created by Kim TaeSoo on 2023/06/04.
//

import Foundation
// MARK: - MyQueueState
struct RunningNoticeGet: Codable {
    let id: Int
    let createdDate, title, detail: String
    let member: Member
    let noticeType: String
    let runningMemberCount, runningPersonnel: Int
    let runningDateTime, status: String
    let preRunningRecord: PreRunningRecord
}

// MARK: - Member
struct Member: Codable {
    let id: Int
    let memberRole: String
    let user: User
}

// MARK: - User
struct User: Codable {
    let id: Int
    let nickname, imgURL: String

    enum CodingKeys: String, CodingKey {
        case id, nickname
        case imgURL = "imgUrl"
    }
}

// MARK: - PreRunningRecord
struct PreRunningRecord: Codable {
    let id: Int
    let title, startDateTime, location: String
    let runningDistance: Double
    let runningTime, runningFace: Int
}
