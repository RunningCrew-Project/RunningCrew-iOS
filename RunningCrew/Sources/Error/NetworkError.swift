//
//  NetworkError.swift
//  RunningCrew
//
//  Created by 김기훈 on 2023/07/26.
//

import Foundation

enum NetworkError: Error {
    case client
    case server
}

extension NetworkError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .client: return "사용자 정보가 정확하지 않습니다."
        case .server: return "서버에 문제가 있습니다."
        }
    }
}
