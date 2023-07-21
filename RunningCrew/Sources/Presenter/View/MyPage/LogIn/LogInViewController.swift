//
//  LogInViewController.swift
//  RunningCrew
//
//  Created by 김기훈 on 2023/07/21.
//

import UIKit
import RxCocoa
import KakaoSDKUser

final class LogInViewController: BaseViewController {
    
    private var logInView: LogInView!
    
    override func loadView() {
        self.logInView = LogInView()
        self.view = logInView
    }
    
    override func bind() {
        logInView.kakaoLogInButton.rx.tap
            .bind { [weak self] _ in self?.kakaoLogIn() }
            .disposed(by: disposeBag)
        
        logInView.googleLogInButton.rx.tap
            .bind { }
            .disposed(by: disposeBag)
        
        logInView.appleLogInButton.rx.tap
            .bind { }
            .disposed(by: disposeBag)
    }
}

extension LogInViewController {
    private func kakaoLogIn() {
        if (UserApi.isKakaoTalkLoginAvailable()) {
            UserApi.shared.loginWithKakaoTalk { (oauthToken, error) in
                if let error = error {
                    print(error)
                } else {
                    print("카카오톡으로 로그인 성공")
                    print("토큰", oauthToken)
                }
            }
        } else {
            UserApi.shared.loginWithKakaoAccount { (oauthToken, error) in
                if let error = error {
                    print(error)
                } else {
                    print("카카오 계정으로 로그인 성공")
                    print("토큰", oauthToken)
                }
            }
        }
    }
}
