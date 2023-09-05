//
//  CrewAPI.swift
//  RunningCrew
//
//  Created by 김기훈 on 2023/08/07.
//

import Foundation
import Moya

enum CrewAPI {
    case getCrew(crewID: Int)
    case getAllJoinCrews(accessToken: String)
    case getRecommendCrews(guID: Int)
}

 extension CrewAPI: TargetType {
    var baseURL: URL {
        return URL(string: "https://runningcrew-test.ddns.net")!
    }
    
    var path: String {
        switch self {
        case .getCrew(let crewID): return "/api/crews/\(crewID)"
        case .getAllJoinCrews: return "/api/users/crews"
        case .getRecommendCrews(let guID): return "/api/crews/gu-areas/\(guID)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getCrew: return .get
        case .getAllJoinCrews: return .get
        case .getRecommendCrews: return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getCrew: return .requestPlain
        case .getAllJoinCrews: return .requestPlain
        case .getRecommendCrews: return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .getCrew: return nil
        case .getAllJoinCrews(let accessToken): return ["Authorization": "Bearer \(accessToken)"]
        case .getRecommendCrews: return nil
        }
    }
 }
