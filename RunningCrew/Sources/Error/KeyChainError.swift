//
//  KeyChainError.swift
//  RunningCrew
//
//  Created by 김기훈 on 2023/07/26.
//

import Foundation

enum KeyChainError: Error {
    case readToken
}

extension KeyChainError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .readToken: return "키체인에서 토큰을 읽을 수 없습니다."
        }
    }
}
