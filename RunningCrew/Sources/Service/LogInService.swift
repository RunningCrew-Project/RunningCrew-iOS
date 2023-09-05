//
//  LogInManager.swift
//  RunningCrew
//
//  Created by 김기훈 on 2023/07/21.
//

import Foundation
import RxSwift
import RxRelay

final class LogInService {
    
    static let shared = LogInService()
    
    private let userRepository: UserRepository = UserRepository()
    private let tokenRepository: TokenRepository = TokenRepository()
    let isLogIn: BehaviorRelay<Bool> = BehaviorRelay<Bool>(value: false)
    let me: BehaviorRelay<Me?> = BehaviorRelay<Me?>(value: nil)
    
    private var disposeBag = DisposeBag()
    
    private init () {
        self.configure()
    }
    
    private func configure() {
        
        guard let accessToken = try? tokenRepository.readToken(key: "accessToken"),
              let refreshToken = try? tokenRepository.readToken(key: "refreshToken") else {
            isLogIn.accept(false)
            return
        }

        getMe(accessToken: accessToken, refreshToken: refreshToken)
    }
    
    private func getMe(accessToken: String, refreshToken: String) {
        userRepository.getMe(accessToken: accessToken)
            .map { try JSONDecoder().decode(Me.self, from: $0) }
            .subscribe(onNext: { [weak self] me in
                self?.me.accept(me)
                self?.isLogIn.accept(true)
            }, onError: { [weak self] _ in
                self?.updateAccessToken(refreshToken: refreshToken)
            })
            .disposed(by: disposeBag)
    }
    
    private func updateAccessToken(refreshToken: String) {
        tokenRepository.updateAccessToken(refreshToken: refreshToken)
            .subscribe(onNext: { [weak self] tokens in
                _ = self?.saveToken(key: "accessToken", token: tokens[0])
                if tokens.count == 2 { _ = self?.saveToken(key: "refreshToken", token: tokens[1]) }
                self?.isLogIn.accept(true)
            }, onError: { [weak self] _ in
                self?.isLogIn.accept(false)
            })
            .disposed(by: disposeBag)
    }
}
 
extension LogInService {
    func logIn(accessToken: String = "", idToken: String = "", origin: String) -> Observable<OAuthResponse> {
        guard let fcmToken = try? tokenRepository.readToken(key: "fcmToken") else {
            return Observable.error(KeyChainError.readToken)
        }
        let oAuthRequest = OAuthRequest(fcmToken: fcmToken, accessToken: accessToken, idToken: idToken, origin: origin)

        return userRepository.oAuthLogIn(body: oAuthRequest)
            .map { try JSONDecoder().decode(OAuthResponse.self, from: $0) }
            .withUnretained(self)
            .map { (owner, response) -> OAuthResponse in
                if response.initData {
                    owner.getMe(accessToken: response.accessToken, refreshToken: response.refreshToken)
                    _ = owner.saveToken(key: "accessToken", token: response.accessToken)
                    _ = owner.saveToken(key: "refreshToken", token: response.refreshToken)
                }
                return response
            }
    }
    
    func logOut() -> Bool {
        if tokenRepository.deleteToken(key: "accessToken") == false || tokenRepository.deleteToken(key: "refreshToken") == false {
            return false
        }
        isLogIn.accept(false)
        return true
    }
}

extension LogInService {
    func signUp(accessToken: String, refreshToken: String, signUpData: SignUpUser) -> Observable<SignUpUser> {
        return userRepository.signUp(accessToken: accessToken, signUpData: signUpData)
            .map { try JSONDecoder().decode(SignUpUser.self, from: $0) }
            .map { [weak self] signUpUser in
                self?.getMe(accessToken: accessToken, refreshToken: refreshToken)
                return signUpUser
            }
    }
    
    func withDrawal() -> Observable<Bool> {
        guard let accessToken = try? tokenRepository.readToken(key: "accessToken") else {
            return Observable.error(KeyChainError.readToken)
        }
        
        guard let me = me.value else {
            return Observable.empty()
        }
        
        return userRepository.withDrawal(accessToken: accessToken, userID: me.id)
            .withUnretained(self)
            .map { (owner, result) in
                if result {
                    _ = owner.logOut()
                }
                return result
            }
    }
}

extension LogInService {
    func saveToken(key: String, token: String) -> Bool {
        if tokenRepository.saveToken(key: key, value: token) == false {
            return tokenRepository.updateSavedToken(key: key, newValue: token)
        }
        return true
    }
}
