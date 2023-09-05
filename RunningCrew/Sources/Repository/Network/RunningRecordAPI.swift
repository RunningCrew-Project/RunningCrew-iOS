//
//  RunningRecordAPI.swift
//  RunningCrew
//
//  Created by 김기훈 on 2023/08/10.
//

import Moya

enum RunningRecordAPI {
    case createPersonalRunningRecord(accessToken: String, data: RunningRecord)
    case getAllRunningRecord(accessToken: String, userID: Int, page: Int)
}

extension RunningRecordAPI: TargetType {
    var baseURL: URL {
        return URL(string: "https://runningcrew-test.ddns.net")!
    }
    
    var path: String {
        switch self {
        case .createPersonalRunningRecord: return "/api/running-records/personal"
        case .getAllRunningRecord(_, let userID, _): return "/api/users/\(userID)/running-records"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .createPersonalRunningRecord: return .post
        case .getAllRunningRecord: return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .createPersonalRunningRecord(_, let data):
            var formData: [Moya.MultipartFormData] = [
                Moya.MultipartFormData(provider: .data(data.startDateTime.data(using: .utf8) ?? Data()), name: "startDateTime"),
                Moya.MultipartFormData(provider: .data(data.location.data(using: .utf8) ?? Data()), name: "location"),
                Moya.MultipartFormData(provider: .data("\(data.runningDistance)".data(using: .utf8) ?? Data()), name: "runningDistance"),
                Moya.MultipartFormData(provider: .data("\(data.runningTime)".data(using: .utf8) ?? Data()), name: "runningTime"),
                Moya.MultipartFormData(provider: .data("\(data.runningPace)".data(using: .utf8) ?? Data()), name: "runningFace"),
                Moya.MultipartFormData(provider: .data("\(data.calories)".data(using: .utf8) ?? Data()), name: "calories"),
                Moya.MultipartFormData(provider: .data(data.runningDetails.data(using: .utf8) ?? Data()), name: "runningDetails")
            ]
            
            if let gpsData = try? JSONEncoder().encode(data.gps) {
                formData.append(Moya.MultipartFormData(provider: .data(gpsData), name: "gps"))
            }
            
            for fileData in data.files {
                formData.append(Moya.MultipartFormData(provider: .data(fileData), name: "files"))
            }
            
            return .uploadMultipart(formData)
        case .getAllRunningRecord(_, _, let page): return .requestParameters(parameters: ["page": page], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .createPersonalRunningRecord(let accessToken, _): return ["Content-Type": "application/json", "Authorization": "Bearer \(accessToken)"]
        case .getAllRunningRecord(let accessToken, _, _): return ["Content-Type": "application/json", "Authorization": "Bearer \(accessToken)"]
        }
    }
}
