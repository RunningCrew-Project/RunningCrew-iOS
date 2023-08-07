//
//  LogInManager.swift
//  RunningCrew
//
//  Created by 김기훈 on 2023/07/21.
//

import Foundation
import RxSwift

final class LogInService {
    private let userRepository: UserRepository
    private let keyChainRepository: KeyChainRepository = KeyChainRepository.shared
    
    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
}
 
extension LogInService {
    func logIn(accessToken: String = "", idToken: String = "", origin: String) -> Observable<SocialLogInResponse> {
        guard let fcmToken = try? keyChainRepository.readToken(key: "fcmToken") else {
            return Observable.error(KeyChainError.readToken)
        }
        let model = SocialLogInRequest(fcmToken: fcmToken, accessToken: accessToken, idToken: idToken, origin: origin)
        
        return userRepository.logIn(body: model)
            .map { try JSONDecoder().decode(SocialLogInResponse.self, from: $0) }
            .withUnretained(self)
            .map { (owner, response) in
                if owner.keyChainRepository.saveToken(key: "accessToken", value: response.accessToken) == false {
                    _ = owner.keyChainRepository.updateToken(key: "accessToken", newValue: response.accessToken)
                }
                if owner.keyChainRepository.saveToken(key: "refreshToken", value: response.refreshToken) == false {
                    _ = owner.keyChainRepository.updateToken(key: "refreshToken", newValue: response.refreshToken)
                }
                
                return response
            }
    }
    
    func isLogIn() -> Bool {
        guard (try? keyChainRepository.readToken(key: "accessToken")) != nil else {
            return false
        }
        return true
    }
    
    func logOut() -> Bool {
        if keyChainRepository.deleteToken(key: "accessToken") {
            return keyChainRepository.deleteToken(key: "refreshToken")
        }
        return false
    }
    
    func getUserData() -> Observable<Me> {
        guard let accessToken = try? keyChainRepository.readToken(key: "accessToken") else {
            return Observable.error(KeyChainError.readToken)
        }
        
        return userRepository.logInUserInformation(accessToken: accessToken)
            .map { try JSONDecoder().decode(Me.self, from: $0) }
    }
    
    func signUp(accessToken: String, name: String, nickName: String, dongId: Int, birthday: String, sex: String, height: Int, weight: Int) -> Observable<User> {
        return userRepository.signUp(accessToken: accessToken, name: name, nickName: nickName, dongId: dongId, birthday: birthday, sex: sex, height: height, weight: weight)
            .map { try JSONDecoder().decode(User.self, from: $0) }
    }
    
    func deleteUser() -> Observable<Bool> {
        guard let accessToken = try? keyChainRepository.readToken(key: "accessToken") else {
            return Observable.error(KeyChainError.readToken)
        }
        
        return getUserData()
            .withUnretained(self)
            .flatMap { (owner, me) in owner.userRepository.deleteUser(accessToken: accessToken, userID: "\(me.id)") }
            .withUnretained(self)
            .map { (owner, result) in
                if result {
                    _ = owner.logOut()
                }
                return result
            }
    }
}
