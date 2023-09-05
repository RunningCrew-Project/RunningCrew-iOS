//
//  AlarmService.swift
//  RunningCrew
//
//  Created by 김기훈 on 2023/08/23.
//

import Foundation
import RxSwift

final class AlarmService {
    
    private let crewRepository: CrewRepository
    private let tokenRepository: TokenRepository
    
    init(crewRepository: CrewRepository, tokenRepository: TokenRepository) {
        self.crewRepository = crewRepository
        self.tokenRepository = tokenRepository
    }
    
    func getNotification(page: Int) -> Observable<Notification> {
        guard let accessToken = try? tokenRepository.readToken(key: "accessToken") else {
            return Observable.error(KeyChainError.readToken)
        }
        
        return crewRepository.getNotification(accessToken: accessToken, page: page)
            .map { try JSONDecoder().decode(Notification.self, from: $0) }
    }
    
    func getNotice() -> Observable<RunningNotices> {
        guard let accessToken = try? tokenRepository.readToken(key: "accessToken") else {
            return Observable.error(KeyChainError.readToken)
        }
        
        return crewRepository.getNotice(accessToken: accessToken)
            .map { try JSONDecoder().decode(RunningNotices.self, from: $0) }
    }
}
