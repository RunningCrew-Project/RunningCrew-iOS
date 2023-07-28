//
//  LogInViewModel.swift
//  RunningCrew
//
//  Created by 김기훈 on 2023/07/24.
//

import Foundation
import RxSwift
import RxRelay

final class LogInViewModel: NSObject, BaseViewModelType {
    
    struct Input {
        let kakaoLogInDidTap: Observable<String>
        let googleLogInDidTap: Observable<(accessToken: String, idToken: String)>
        let appleLogInDidTap: Observable<String>
    }
    
    struct Output {
        let socialLogInResponse: Observable<SocialLogInResponseModel>
    }
    
    private let logInService: LogInService
    
    var disposeBag = DisposeBag()
    
    init(logInService: LogInService) {
        self.logInService = logInService
    }
    
    func transform(input: Input) -> Output {
        let kakaoLogInDiaTap = input.kakaoLogInDidTap
            .withUnretained(self)
            .flatMap { (owner, accessToken) -> Observable<SocialLogInResponseModel> in
                return owner.logInService.logIn(accessToken: accessToken, origin: "kakao")
            }
        
        let googleLogInDidTap = input.googleLogInDidTap
            .withUnretained(self)
            .flatMap { (owner, tokens) -> Observable<SocialLogInResponseModel> in
                return owner.logInService.logIn(accessToken: tokens.accessToken, idToken: tokens.idToken, origin: "google")
            }
        
        let appleLogInDidTap = input.appleLogInDidTap
            .withUnretained(self)
            .flatMap { (owner, idToken) -> Observable<SocialLogInResponseModel> in
                if idToken == "" { return Observable.error(TokenError.getToken) }
                return owner.logInService.logIn(idToken: idToken, origin: "apple")
            }
        
        let socialLogInResponse = Observable.merge(kakaoLogInDiaTap, googleLogInDidTap, appleLogInDidTap)
            .withUnretained(self)
            .map { (owner, response) -> SocialLogInResponseModel in
                if response.initData {
                    owner.logInService.storeToken(key: "accessToken", value: response.accessToken)
                    owner.logInService.storeToken(key: "refreshToken", value: response.refreshToken)
                }
                return response
            }
     
        return Output(socialLogInResponse: socialLogInResponse)
    }
}
