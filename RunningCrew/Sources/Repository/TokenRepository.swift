//
//  TokenRepository.swift
//  RunningCrew
//
//  Created by 김기훈 on 2023/08/09.
//

import Foundation
import Moya
import RxSwift

final class TokenRepository {
    
    private let keyChainManager = KeyChainManager.shared
    private var refreshTokenProvider = MoyaProvider<RefreshTokenAPI>()
    
    func readToken(key: String) throws -> String {
        return try keyChainManager.read(key: key)
    }
    
    func saveToken(key: String, value: String) -> Bool {
        return keyChainManager.save(key: key, value: value)
    }
    
    func deleteToken(key: String) -> Bool {
        return keyChainManager.delete(key: key)
    }
    
    func updateSavedToken(key: String, newValue: String) -> Bool {
        return keyChainManager.update(key: key, newValue: newValue)
    }
    
    func updateAccessToken(refreshToken: String) -> Observable<[String]> {
        return refreshTokenProvider.rx.request(.updateToken(refreshToken: refreshToken))
            .map { response -> [String] in
                if 400..<500 ~= response.statusCode {
                    throw NetworkError.client
                } else if 500..<600 ~= response.statusCode {
                    throw NetworkError.server
                }
                
                if let headers = response.response?.allHeaderFields as? [String: String], let cookies = headers["Set-Cookie"] {
                    let startIndex = cookies.index(cookies.startIndex, offsetBy: 13)
                    let endIndex = cookies.endIndex
                    let range = startIndex...endIndex
                    
                    return [response.response?.headers["Authorization"] ?? "", String(cookies[range])]
                }
                
                return [(response.response?.headers["Authorization"] ?? "").components(separatedBy: " ")[1]]
            }
            .asObservable()
    }
}
