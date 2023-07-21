//
//  LogInViewController.swift
//  RunningCrew
//
//  Created by 김기훈 on 2023/07/21.
//

import UIKit
import RxCocoa
import RxSwift
import RxGesture
import KakaoSDKUser
import GoogleSignIn

final class LogInViewController: BaseViewController {
    
    private var logInView: LogInView!
    
    override func loadView() {
        self.logInView = LogInView()
        self.view = logInView
    }
    
    override func bind() {
        logInView.kakaoLogInButton.rx.tap
            .throttle(.seconds(2), scheduler: MainScheduler.instance)
            .bind { [weak self] _ in self?.kakaoLogInDidTap() }
            .disposed(by: disposeBag)
        
        logInView.googleLogInButton.rx.tap
            .throttle(.seconds(2), scheduler: MainScheduler.instance)
            .bind { [weak self] _ in self?.googleLogInDidTap() }
            .disposed(by: disposeBag)
        
        logInView.appleLogInButton.rx.tap
            .throttle(.seconds(2), scheduler: MainScheduler.instance)
            .bind { _ in }
            .disposed(by: disposeBag)
    }
}

extension LogInViewController {
    private func kakaoLogInDidTap() {
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
    
    private func googleLogInDidTap() {
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { signInResult, error in
            guard error == nil else { return }
            
            print(signInResult?.user.accessToken.tokenString)
            print(signInResult?.user.idToken?.tokenString)
        }
    }
}
