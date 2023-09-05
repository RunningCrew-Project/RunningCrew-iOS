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
import RxRelay
import KakaoSDKUser
import GoogleSignIn
import AuthenticationServices

protocol LogInViewControllerDelegate: AnyObject {
    func popLogInView()
    func showSignUpView(accessToken: String, refreshToken: String)
}

final class LogInViewController: BaseViewController {
    
    weak var coordinator: LogInViewControllerDelegate?
    
    private var logInView: LogInView!
    private let viewModel: LogInViewModel
    private var logInType: PublishRelay<LogInViewModel.LogInType> = PublishRelay<LogInViewModel.LogInType>()
    
    init(viewModel: LogInViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.logInView = LogInView()
        self.view = logInView
    }
    
    override func bind() {
        let input = LogInViewModel.Input(logInType: logInType.asObservable())
        let output = viewModel.transform(input: input)
        
        output.oAuthResponse
            .withUnretained(self)
            .bind { (owner, response) in
                guard let response = response else {
                    owner.failLogInAlert()
                    return
                }
                
                if response.initData {
                    owner.coordinator?.popLogInView()
                } else {
                    owner.coordinator?.showSignUpView(accessToken: response.accessToken, refreshToken: response.refreshToken)
                }
            }
            .disposed(by: disposeBag)
        
        logInView.kakaoLogInButton.rx.tap
            .throttle(.seconds(1), scheduler: MainScheduler.instance)
            .withUnretained(self)
            .bind { (owner, _) in
                owner.kakaoLogIn()
            }
            .disposed(by: disposeBag)
        
        logInView.googleLogInButton.rx.tap
            .throttle(.seconds(1), scheduler: MainScheduler.instance)
            .withUnretained(self)
            .bind { (owner, _) in
                owner.googleLogIn()
            }
            .disposed(by: disposeBag)
        
        logInView.appleLogInButton.rx.tapGesture().when(.recognized)
            .throttle(.seconds(1), scheduler: MainScheduler.instance)
            .bind { [weak self] _ in self?.appleLogIn() }
            .disposed(by: disposeBag)
    }
}

extension LogInViewController {
    private func failLogInAlert(reason: String = "") {
        let confirmAction = UIAlertAction(title: "확인", style: .cancel)
        showAlert(title: "로그인 실패", message: "로그인에 실패했습니다.\(reason == "" ? "" : reason)", actions: [confirmAction])
    }
    
    private func kakaoLogIn() {
        if UserApi.isKakaoTalkLoginAvailable() {
            UserApi.shared.loginWithKakaoTalk { [weak self] (oauthToken, error) in
                guard error == nil,
                      let oauthToken = oauthToken else {
                    self?.failLogInAlert()
                    return
                }
                self?.logInType.accept(.kakao(accessToken: oauthToken.accessToken))
            }
        } else {
            UserApi.shared.loginWithKakaoAccount { [weak self] (oauthToken, error) in
                guard error == nil,
                      let oauthToken = oauthToken else {
                    self?.failLogInAlert()
                    return
                }
                self?.logInType.accept(.kakao(accessToken: oauthToken.accessToken))
            }
        }
    }
    
    private func googleLogIn() {
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { [weak self] (result, error) in
            guard error == nil,
                  let result = result,
                  let idToken = result.user.idToken?.tokenString else {
                self?.failLogInAlert()
                return
            }
            self?.logInType.accept(.google(accessToken: result.user.accessToken.tokenString, idToken: idToken))
        }
    }
}

extension LogInViewController: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    private func appleLogIn() {
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
              let identityToken = credential.identityToken,
              let identityTokenString = String(data: identityToken, encoding: .utf8) else {
            self.failLogInAlert()
            return
        }
        logInType.accept(.apple(idToken: identityTokenString))
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print(error)
        self.failLogInAlert()
    }
}
