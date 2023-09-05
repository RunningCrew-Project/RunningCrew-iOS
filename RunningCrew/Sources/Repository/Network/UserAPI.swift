//
//  UserAPI.swift
//  RunningCrew
//
//  Created by 김기훈 on 2023/08/07.
//

import Moya

enum UserAPI {
    case getUser(accessToken: String, userID: Int)
    case updateUser(accessToken: String, user: UpdateUser)
    case withDrawal(accessToken: String, userID: Int)
    case validateEmail(email: String)
    case validateNickName(nickName: String)
    case getMe(accessToken: String)
}

extension UserAPI: TargetType {
    var baseURL: URL {
        return URL(string: "https://runningcrew-test.ddns.net")!
    }
    
    var path: String {
        switch self {
        case .getUser(_, let userID): return "/api/users/\(userID)"
        case .updateUser(_, let userID): return "/api/users/\(userID)"
        case .withDrawal(_, let userID): return "/api/users/\(userID)"
        case .validateEmail: return "/api/users/duplicate/email"
        case .validateNickName: return "/api//users/duplicate/nickname"
        case .getMe: return "/api/me"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getUser: return .get
        case .updateUser: return .put
        case .withDrawal: return .delete
        case .validateEmail: return .post
        case .validateNickName: return .post
        case .getMe: return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getUser: return .requestPlain
        case .updateUser(_, let user): return .requestJSONEncodable(user)
        case .withDrawal: return .requestPlain
        case .validateEmail(let email): return .requestParameters(parameters: ["email": email], encoding: URLEncoding.httpBody)
        case .validateNickName(let nickName): return .requestParameters(parameters: ["nickname": nickName], encoding: URLEncoding.httpBody)
        case .getMe: return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .getUser(let accessToken, _): return ["Authorization": "Bearer \(accessToken)"]
        case .updateUser(let accessToken, _): return ["Authorization": "Bearer \(accessToken)"]
        case .withDrawal(let accessToken, _): return ["Authorization": "Bearer \(accessToken)"]
        case .validateEmail: return nil
        case .validateNickName: return nil
        case .getMe(let accessToken): return ["Authorization": "Bearer \(accessToken)"]
        }
    }
}
