//
//  AllRunningRecord.swift
//  RunningCrew
//
//  Created by 김기훈 on 2023/08/13.
//

import Foundation

struct AllRunningRecord: Codable {
    let content: [AllRunningRecordContent]
    let size, number, numberOfElements: Int
    let first, last, hasNext: Bool
}

struct AllRunningRecordContent: Codable, Hashable {
    let id: Int
    let title, startDateTime, location: String
    let runningDistance: Double
    let runningTime, runningFace: Int
}
