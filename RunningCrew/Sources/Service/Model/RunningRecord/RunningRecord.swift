//
//  RunningRecord.swift
//  RunningCrew
//
//  Created by 김기훈 on 2023/08/10.
//

import Foundation

struct GPSPoint: Codable {
    let latitude: Double
    let longitude: Double
}

struct RunningRecord: Codable {
    let startDateTime: String
    let location: String
    let runningDistance: Double
    let runningTime: Int
    let runningPace: Int
    let calories: Int
    var runningDetails: String
    let gps: [GPSPoint]
    var files: [Data]
    let runningNoticeId: Int?
}
