//
//  RunningRecordRepository.swift
//  RunningCrew
//
//  Created by 김기훈 on 2023/08/10.
//

import Foundation
import Moya
import RxSwift

final class RunningRecordRepository {
    private var runningRecordProvider = MoyaProvider<RunningRecordAPI>()
    
    func createPersonalRunningRecord(accessToken: String, data: RunningRecord) -> Observable<Bool> {
        return runningRecordProvider.rx.request(.createPersonalRunningRecord(accessToken: accessToken, data: data))
            .map { response -> Bool in
                return response.statusCode == 201
            }
            .asObservable()
    }
    
    func getAllRunningRecord(accessToken: String, userID: Int, page: Int) -> Observable<Data> {
        return runningRecordProvider.rx.request(.getAllRunningRecord(accessToken: accessToken, userID: userID, page: page))
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
