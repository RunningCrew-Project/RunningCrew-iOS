//
//  AreaAPI.swift
//  RunningCrew
//
//  Created by 김기훈 on 2023/08/31.
//

import Moya

enum AreaAPI {
    case getSi
    case getGu(siID: Int)
    case getDong(guId: Int)
    case getGuID(keyword: String)
}

extension AreaAPI: TargetType {
    var baseURL: URL {
        return URL(string: "https://runningcrew-test.ddns.net")!
    }
    
    var path: String {
        switch self {
        case .getSi: return "/api/sido-areas"
        case .getGu(let siID): return "/api/sido-areas/\(siID)/gu-areas"
        case .getDong(let guId): return "/api/gu-areas/\(guId)/dong-areas"
        case .getGuID: return "/api/gu-areas"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Moya.Task {
        switch self {
        case .getGuID(let keyword): return .requestParameters(parameters: ["name": keyword], encoding: URLEncoding.queryString)
        default: return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        return nil
    }
}
