//
//  RunningNoticeAPI.swift
//  RunningCrew
//
//  Created by 김기훈 on 2023/08/23.
//

import Moya

enum RunningNoticeAPI {
    case getRunningNotice(accessToken: String)
}

extension RunningNoticeAPI: TargetType {
    var baseURL: URL {
        return URL(string: "https://runningcrew-test.ddns.net")!
    }
    
    var path: String {
        switch self {
        case .getRunningNotice: return "/api/running-notices"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getRunningNotice: return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getRunningNotice: return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .getRunningNotice(let accessToken): return ["Authorization": "Bearer \(accessToken)"]
        }
    }
}
