//
//  UserService.swift
//  RunningCrew
//
//  Created by 김기훈 on 2023/08/13.
//

import Foundation
import RxSwift

final class UserService {
    
    private let userRepository: UserRepository
    private let tokenRepository: TokenRepository
    
    init(userRepository: UserRepository, tokenRepository: TokenRepository) {
        self.userRepository = userRepository
        self.tokenRepository = tokenRepository
    }
    
    func getProfile(userID: Int) -> Observable<User> {
        guard let accessToken = try? tokenRepository.readToken(key: "accessToken") else {
            return Observable.error(KeyChainError.readToken)
        }
        
        return userRepository.getUser(accessToken: accessToken, userID: userID)
            .map { try JSONDecoder().decode(User.self, from: $0) }
    }
    
    func validateNickName(nickName: String) -> Observable<Bool> {
        return userRepository.validateNickName(nickName: nickName)
    }
}
