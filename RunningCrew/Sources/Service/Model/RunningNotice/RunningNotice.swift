//
//  RunningNotice.swift
//  RunningCrew
//
//  Created by 김기훈 on 2023/08/23.
//

import Foundation

struct RunningNotices: Codable {
    let runningNotices: [RunningNotice]
}

struct RunningNotice: Codable, Hashable {
    let id: Int
    let title, noticeType, runningDateTime: String
    let runningMemberCount: Int
}
