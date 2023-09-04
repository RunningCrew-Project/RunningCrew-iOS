//
//  OAuthAPI.swift
//  RunningCrew
//
//  Created by 김기훈 on 2023/08/09.
//

import Moya

enum OAuthAPI {
    case oAuthLogIn(body: OAuthRequest)
    case signUp(accessToken: String, signUpData: SignUpUser)
}

extension OAuthAPI: TargetType {
    var baseURL: URL {
        return URL(string: "https://runningcrew-test.ddns.net")!
    }
    
    var path: String {
        switch self {
        case .oAuthLogIn: return "/api/login/oauth"
        case .signUp: return "/api/signup"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .oAuthLogIn: return .post
        case .signUp: return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .oAuthLogIn(let body): return .requestJSONEncodable(body)
        case .signUp(_, let user):
            let name = Moya.MultipartFormData(provider: .data("\(user.name)".data(using: .utf8)!), name: "name")
            let nickname = Moya.MultipartFormData(provider: .data("\(user.nickname)".data(using: .utf8)!),
                                                   name: "nickname")
            let dongId = Moya.MultipartFormData(provider: .data("\(user.dongId)".data(using: .utf8)!),
                                                   name: "dongId")
            let birthday = Moya.MultipartFormData(provider: .data("\(user.birthday)".data(using: .utf8)!),
                                                   name: "birthday")
            let sex = Moya.MultipartFormData(provider: .data("\(user.sex)".data(using: .utf8)!),
                                                   name: "sex")
            let height = Moya.MultipartFormData(provider: .data("\(user.height)".data(using: .utf8)!),
                                                   name: "height")
            let weight = Moya.MultipartFormData(provider: .data("\(user.weight)".data(using: .utf8)!),
                                                   name: "weight")
            return .uploadMultipart([name, nickname, dongId, birthday, sex, height, weight])
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .oAuthLogIn: return nil
        case .signUp(let accessToken, _): return ["Content-Type": "multipart/form-data", "Authorization": "Bearer \(accessToken)"]
        }
    }
}
