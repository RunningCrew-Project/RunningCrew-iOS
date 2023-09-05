//
//  NotificationAPI.swift
//  RunningCrew
//
//  Created by 김기훈 on 2023/08/23.
//

import Moya

enum NotificationAPI {
    case getNotification(accessToken: String, page: Int)
}

extension NotificationAPI: TargetType {
    var baseURL: URL {
        return URL(string: "https://runningcrew-test.ddns.net")!
    }
    
    var path: String {
        switch self {
        case .getNotification: return "/api/notifications"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getNotification: return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getNotification(_, let page): return .requestParameters(parameters: ["page": page], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .getNotification(let accessToken, _): return ["Authorization": "Bearer \(accessToken)"]
        }
    }
}
