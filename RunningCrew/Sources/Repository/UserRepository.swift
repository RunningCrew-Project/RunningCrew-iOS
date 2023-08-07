//
//  UserRepository.swift
//  RunningCrew
//
//  Created by 김기훈 on 2023/07/24.
//

import Foundation
import Moya
import RxSwift

final class UserRepository {
    private var userProvider = MoyaProvider<UserAPI>()
    
    func logIn(body: SocialLogInRequest) -> Observable<Data> {
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
    
    func logInUserInformation(accessToken: String) -> Observable<Data> {
        return userProvider.rx.request(.logInUserInformation(accessToken: accessToken))
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
    
    func signUp(accessToken: String, name: String, nickName: String, dongId: Int, birthday: String, sex: String, height: Int, weight: Int) -> Observable<Data> {
        return userProvider.rx.request(.signUp(accessToken: accessToken, name: name, nickName: nickName, dongId: dongId, birthday: birthday, sex: sex, height: height, weight: weight))
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
    
    func deleteUser(accessToken: String, userID: String) -> Observable<Bool> {
        return userProvider.rx.request(.deleteUser(accessToken: accessToken, userID: userID))
            .map { response -> Bool in
                if 400..<600 ~= response.statusCode {
                    return false
                }
                return true
            }
            .asObservable()
    }
}
