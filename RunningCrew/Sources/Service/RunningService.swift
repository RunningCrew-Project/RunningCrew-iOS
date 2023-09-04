//
//  RunningService.swift
//  RunningCrew
//
//  Created by 김기훈 on 2023/08/09.
//

import Foundation
import RxSwift

final class RunningService {
    
    private let runningRecordRepository: RunningRecordRepository
    private let tokenRepository: TokenRepository
    private let crewRepository: CrewRepository
    
    init(runningRecordRepository: RunningRecordRepository, tokenRepository: TokenRepository, crewRepository: CrewRepository) {
        self.runningRecordRepository = runningRecordRepository
        self.tokenRepository = tokenRepository
        self.crewRepository = crewRepository
    }
    
    func createPersonalRunningRecord(data: RunningRecord) -> Observable<Bool> {
        guard let accessToken = try? tokenRepository.readToken(key: "accessToken") else {
            return Observable.error(KeyChainError.readToken)
        }
        
        return runningRecordRepository.createPersonalRunningRecord(accessToken: accessToken, data: data)
    }
    
    func getMyCrewRunning() -> Observable<[Crew]> {
        guard let accessToken = try? tokenRepository.readToken(key: "accessToken") else {
            return Observable.error(KeyChainError.readToken)
        }
        
        return crewRepository.getAllJoinCrews(accessToken: accessToken)
            .map { try JSONDecoder().decode(AllJoinCrew.self, from: $0).crews }
            .flatMap { allJoinCrew -> Observable<[Crew]> in
                let observables = allJoinCrew.map { crew in
                    self.crewRepository.getCrew(crewID: crew.id)
                        .map { try JSONDecoder().decode(Crew.self, from: $0) }
                }
                return Observable.zip(observables)
            }
    }
    
    func getAllMyRunningRecord(userID: Int, page: Int) -> Observable<[AllRunningRecordContent]> {
        guard let accessToken = try? tokenRepository.readToken(key: "accessToken") else {
            return Observable.error(KeyChainError.readToken)
        }
        
        return runningRecordRepository.getAllRunningRecord(accessToken: accessToken, userID: userID, page: page)
            .map { try JSONDecoder().decode(AllRunningRecord.self, from: $0).content }
    }
    
    func getRecommendCrew(guID: Int) -> Observable<[GuRecommendCrew]> {
        return crewRepository.getRecommendCrew(guID: guID)
            .map { try JSONDecoder().decode(RecommendCrew.self, from: $0).crews }
    }
}
