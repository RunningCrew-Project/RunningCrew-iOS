//
//  RefreshTokenAPI.swift
//  RunningCrew
//
//  Created by 김기훈 on 2023/08/13.
//

import Moya

enum RefreshTokenAPI {
    case updateToken(refreshToken: String)
}

extension RefreshTokenAPI: TargetType {
    var baseURL: URL {
        return URL(string: "https://runningcrew-test.ddns.net")!
    }
    
    var path: String {
        switch self {
        case .updateToken: return "api/refresh"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .updateToken: return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .updateToken: return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .updateToken(let refreshToken): return ["Authorization": "Bearer \(refreshToken)"]
        }
    }
}
