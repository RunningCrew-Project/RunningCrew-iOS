//
//  AreaRepository.swift
//  RunningCrew
//
//  Created by 김기훈 on 2023/08/31.
//

import Foundation
import Moya
import RxSwift

final class AreaRepository {
    private var areaProvider = MoyaProvider<AreaAPI>()
    
    func getSi() -> Observable<Data> {
        return areaProvider.rx.request(.getSi)
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
    
    func getGu(siID: Int) -> Observable<Data> {
        return areaProvider.rx.request(.getGu(siID: siID))
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
    
    func getDong(guID: Int) -> Observable<Data> {
        return areaProvider.rx.request(.getDong(guId: guID))
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
    
    func getGuID(keyword: String) -> Observable<Data> {
        return areaProvider.rx.request(.getGuID(keyword: keyword))
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
