//
//  LogInManager.swift
//  RunningCrew
//
//  Created by 김기훈 on 2023/07/21.
//

import Foundation
import RxSwift

final class LogInService {
    private let logInRepository: UserRepository
    private let keyChainRepository: KeyChainRepository = KeyChainRepository.shared
    
    init(logInRepository: UserRepository) {
        self.logInRepository = logInRepository
    }
}
 
extension LogInService {
    func logIn(accessToken: String = "", idToken: String = "", origin: String) -> Observable<SocialLogInResponseModel> {
        guard let fcmToken = try? keyChainRepository.readToken(key: "fcmToken") else {
            return Observable.error(KeyChainError.readToken)
        }
        let model = SocialLogInRequestModel(fcmToken: fcmToken, accessToken: accessToken, idToken: idToken, origin: origin)
        
        return logInRepository.logIn(body: model)
            .map { try JSONDecoder().decode(SocialLogInResponseModel.self, from: $0) }
    }
    
    func isLogIn() -> Bool {
        guard let accessToken = try? KeyChainRepository.shared.readToken(key: "accessToken") else {
            return false
        }
        //accessToken으로 인증
        return false
    }
    
    func getUserData() -> Observable<User> {
        guard let accessToken = try? KeyChainRepository.shared.readToken(key: "accessToken") else {
            return Observable.error(KeyChainError.readToken)
        }
        
        return logInRepository.isLogIn(accessToken: accessToken)
            .map { try JSONDecoder().decode(User.self, from: $0) }
    }
    
    func storeToken(key: String, value: String) {
        if keyChainRepository.saveToken(key: key, value: value) == false {
            _ = keyChainRepository.updateToken(key: key, newValue: value)
        }
    }
}
