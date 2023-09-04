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
        let logInType: Observable<LogInType>
    }
    
    struct Output {
        let oAuthResponse: Observable<OAuthResponse?>
    }
    
    enum LogInType {
        case kakao(accessToken: String)
        case google(accessToken: String, idToken: String)
        case apple(idToken: String)
    }
    
    private let logInService: LogInService
    private let oAuthResponse: PublishRelay<OAuthResponse?> = PublishRelay()
    var disposeBag = DisposeBag()
    
    init(logInService: LogInService) {
        self.logInService = logInService
    }
    
    func transform(input: Input) -> Output {
        input.logInType
            .withUnretained(self)
            .bind { (owner, logIn) in
                owner.logIn(logInType: logIn)
            }
            .disposed(by: disposeBag)

        return Output(oAuthResponse: oAuthResponse.asObservable())
    }
}

extension LogInViewModel {
    private func logIn(logInType: LogInType) {
        
        switch logInType {
        case .kakao(let accessToken):
            logInService.logIn(accessToken: accessToken, origin: "kakao")
                .subscribe(onNext: { [weak self] response in
                    self?.oAuthResponse.accept(response)
                }, onError: { [weak self] _ in
                    self?.oAuthResponse.accept(nil)
                })
                .disposed(by: disposeBag)
        case .google(let accessToken, let idToken):
            logInService.logIn(accessToken: accessToken, idToken: idToken, origin: "google")
                .subscribe(onNext: { [weak self] response in
                    self?.oAuthResponse.accept(response)
                }, onError: { [weak self] _ in
                    self?.oAuthResponse.accept(nil)
                })
                .disposed(by: disposeBag)
        case .apple(let idToken):
            logInService.logIn(idToken: idToken, origin: "apple")
                .subscribe(onNext: { [weak self] response in
                    self?.oAuthResponse.accept(response)
                }, onError: { [weak self] _ in
                    self?.oAuthResponse.accept(nil)
                })
                .disposed(by: disposeBag)
        }
    }
}
