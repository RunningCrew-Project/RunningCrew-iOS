//
//  UserRepository.swift
//  RunningCrew
//
//  Created by 김기훈 on 2023/07/24.
//

import Foundation
import Moya
import RxSwift

enum UserAPI {
    case logIn(body: SocialLogInRequestModel)
    case signUp(token: String)
    case isLogIn(accessToken: String)
}

extension UserAPI: TargetType {
    var baseURL: URL {
        switch self {
        case .logIn, .signUp, .isLogIn:
            return URL(string: "https://runningcrew-test.ddns.net")!
        }
    }
    
    var path: String {
        switch self {
        case .logIn: return "/api/login/oauth"
        case .signUp: return "/api/signup"
        case .isLogIn: return "/api/me"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .logIn: return .post
        case .signUp: return .post
        case .isLogIn: return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .logIn(let body): return .requestJSONEncodable(body)
        case .signUp: return .requestPlain
        case .isLogIn: return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .logIn: return nil
        case .signUp(let token): return ["Authorization": "Bearer \(token)"]
        case .isLogIn(let accessToken): return ["Authorization": "Bearer \(accessToken)"]
        }
    }
}

final class UserRepository {
    private var userProvider = MoyaProvider<UserAPI>()
    
    func logIn(body: SocialLogInRequestModel) -> Observable<Data> {
        return userProvider.rx.request(.logIn(body: body))
            .map { response -> Data in
                if 400..<500 ~= response.statusCode {
                    throw NetworkError.client
                } else if 500..<600 ~= response.statusCode {
                    throw NetworkError.server
                }
                
                return response.data
            }
            .asObservable()
    }
    
    func isLogIn(accessToken: String) -> Observable<Data> {
        return userProvider.rx.request(.isLogIn(accessToken: accessToken))
            .map { response -> Data in
                if 400..<500 ~= response.statusCode {
                    throw NetworkError.client
                } else if 500..<600 ~= response.statusCode {
                    throw NetworkError.server
                }
                
                return response.data
            }
            .asObservable()
    }
}
