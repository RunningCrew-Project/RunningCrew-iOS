//
//  CrewRepository.swift
//  RunningCrew
//
//  Created by 김기훈 on 2023/08/09.
//

import Foundation
import Moya
import RxSwift

final class CrewRepository {
    
    private var crewProvider = MoyaProvider<CrewAPI>()
    private var notificationProvider = MoyaProvider<NotificationAPI>()
    private var runningNoticeProvider = MoyaProvider<RunningNoticeAPI>()
    
    func getCrew(crewID: Int) -> Observable<Data> {
        return crewProvider.rx.request(.getCrew(crewID: crewID))
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
        
    func getAllJoinCrews(accessToken: String) -> Observable<Data> {
        return crewProvider.rx.request(.getAllJoinCrews(accessToken: accessToken))
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
    
    func getRecommendCrew(guID: Int) -> Observable<Data> {
        return crewProvider.rx.request(.getRecommendCrews(guID: guID))
            .map { response -> Data in
                print(response.statusCode)
                print(String(data: response.data, encoding: .utf8))
                if 400..<500 ~= response.statusCode {
                    throw NetworkError.client
                } else if 500..<600 ~= response.statusCode {
                    throw NetworkError.server
                }
                
                return response.data
            }
            .asObservable()
    }
    
    func getNotification(accessToken: String, page: Int) -> Observable<Data> {
        return notificationProvider.rx.request(.getNotification(accessToken: accessToken, page: page))
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
    
    func getNotice(accessToken: String) -> Observable<Data> {
        return runningNoticeProvider.rx.request(.getRunningNotice(accessToken: accessToken))
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
