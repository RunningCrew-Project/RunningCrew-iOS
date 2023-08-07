//
//  TokenError.swift
//  RunningCrew
//
//  Created by 김기훈 on 2023/07/26.
//

import Foundation

enum TokenError: Error {
    case getToken
}

extension TokenError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .getToken: return "토큰을 받지 못했습니다."
        }
    }
}
