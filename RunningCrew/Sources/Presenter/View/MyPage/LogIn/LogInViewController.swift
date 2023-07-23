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
import AuthenticationServices

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
            .bind { [weak self] _ in self?.appleLogInDidTap() }
            .disposed(by: disposeBag)
    }
}

extension LogInViewController {
    private func kakaoLogInDidTap() {
        if (UserApi.isKakaoTalkLoginAvailable()) {
            UserApi.shared.loginWithKakaoTalk { [weak self] (oauthToken, error) in
                if error != nil {
                    self?.failSocialLogInAlert()
                } else {
                    print("카카오톡으로 로그인 성공")
                    print("토큰", oauthToken)
                }
            }
        } else {
            UserApi.shared.loginWithKakaoAccount { [weak self] (oauthToken, error) in
                if error != nil {
                    self?.failSocialLogInAlert()
                } else {
                    print("카카오 계정으로 로그인 성공")
                    print("토큰", oauthToken)
                }
            }
        }
    }
    
    private func googleLogInDidTap() {
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { [weak self] signInResult, error in
            guard error == nil else {
                self?.failSocialLogInAlert()
                return
            }
            
            print(signInResult?.user.accessToken.tokenString)
            print(signInResult?.user.idToken?.tokenString)
        }
    }
    
    private func failSocialLogInAlert() {
        let confirmAction = UIAlertAction(title: "확인", style: .cancel)
        showAlert(title: "로그인 실패", message: "소셜 로그인에 실패했습니다.", actions: [confirmAction])
    }
}

extension LogInViewController: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    private func appleLogInDidTap() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName]
                
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        guard let credential = authorization.credential as? ASAuthorizationAppleIDCredential,
              let identityToken = credential.identityToken else {
            return
        }
        let identityTokenString = String(data: identityToken, encoding: .utf8)
        
        print(identityTokenString)
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        self.failSocialLogInAlert()
    }
}
