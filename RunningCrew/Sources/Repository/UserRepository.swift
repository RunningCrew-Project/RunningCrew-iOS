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
    private var oAuthProvider = MoyaProvider<OAuthAPI>()
    
    func oAuthLogIn(body: OAuthRequest) -> Observable<Data> {
        return oAuthProvider.rx.request(.oAuthLogIn(body: body))
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
    
    func signUp(accessToken: String, signUpData: SignUpUser) -> Observable<Data> {
        print(signUpData)
        return oAuthProvider.rx.request(.signUp(accessToken: accessToken, signUpData: signUpData))
            .map { response -> Data in
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
    
    func getUser(accessToken: String, userID: Int) -> Observable<Data> {
        return userProvider.rx.request(.getUser(accessToken: accessToken, userID: userID))
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
    
    func updateUser(accessToken: String, user: UpdateUser) -> Observable<Bool> {
        return userProvider.rx.request(.updateUser(accessToken: accessToken, user: user))
            .map { response -> Bool in
                return response.statusCode == 204
            }
            .asObservable()
    }
    
    func withDrawal(accessToken: String, userID: Int) -> Observable<Bool> {
        return userProvider.rx.request(.withDrawal(accessToken: accessToken, userID: userID))
            .map { response -> Bool in
                if 400..<600 ~= response.statusCode {
                    return false
                }
                return true
            }
            .asObservable()
    }
    
    func getMe(accessToken: String) -> Observable<Data> {
        return userProvider.rx.request(.getMe(accessToken: accessToken))
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
    
    func validateNickName(nickName: String) -> Observable<Bool> {
        return userProvider.rx.request(.validateNickName(nickName: nickName))
            .map { response -> Bool in
                if response.statusCode == 204 {
                    return true
                }
                return false
            }
            .asObservable()
    }
}
