//
//  LogInViewController.swift
//  RunningCrew
//
//  Created by 김기훈 on 2023/07/21.
//

import UIKit
import RxCocoa
import RxSwift
import KakaoSDKUser
import GoogleSignIn
import AuthenticationServices

protocol LogInViewControllerDelegate: AnyObject {
    func showMyPageView()
    func showSignUpView(accessToken: String, refreshToken: String)
}

final class LogInViewController: BaseViewController {
    
    weak var coordinator: LogInViewControllerDelegate?
    
    private var logInView: LogInView!
    private let viewModel: LogInViewModel
    private let appleLogInResult: BehaviorRelay<String> = BehaviorRelay<String>(value: "")
    
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
        let kakaoLogInDidTap = logInView.kakaoLogInButton.rx.tap
            .throttle(.seconds(2), scheduler: MainScheduler.instance)
            .withUnretained(self)
            .flatMapLatest { (owner, _) -> Observable<String> in
                return owner.kakaoLogIn()
            }
        let googleLogInDidTap = logInView.googleLogInButton.rx.tap
            .throttle(.seconds(2), scheduler: MainScheduler.instance)
            .withUnretained(self)
            .flatMapLatest { (owner, _) -> Observable<(accessToken: String, idToken: String)> in
                return owner.googleLogIn()
            }
        let appleLogInDidTap = appleLogInResult.skip(1).asObservable()
        
        let input = LogInViewModel.Input(kakaoLogInDidTap: kakaoLogInDidTap,
                                         googleLogInDidTap: googleLogInDidTap,
                                         appleLogInDidTap: appleLogInDidTap)
        let output = viewModel.transform(input: input)
        
        output.socialLogInResponse
            .catch { [weak self] error in
                switch error {
                case NetworkError.client, NetworkError.server, KeyChainError.readToken, TokenError.getToken:
                    self?.failLogInAlert(reason: error.localizedDescription)
                default: break
                }
                return Observable.empty()
            }
            .withUnretained(self)
            .bind { (owner, socialLogInResponse) in
                if socialLogInResponse.initData {
                    owner.coordinator?.showMyPageView()
                } else if socialLogInResponse.initData == false {
                    owner.coordinator?.showSignUpView(accessToken: socialLogInResponse.accessToken, refreshToken: socialLogInResponse.refreshToken)
                }
            }
            .disposed(by: disposeBag)
        
        logInView.appleLogInButton.rx.tap
            .throttle(.seconds(2), scheduler: MainScheduler.instance)
            .bind { self.appleLogIn() }
            .disposed(by: disposeBag)
    }
}

extension LogInViewController {
    private func failLogInAlert(reason: String) {
        let confirmAction = UIAlertAction(title: "확인", style: .cancel)
        showAlert(title: "로그인 실패", message: "로그인에 실패했습니다.\("\n" + reason)", actions: [confirmAction])
    }
    
    private func kakaoLogIn() -> Observable<String> {
        return Observable.create { observer in
            if UserApi.isKakaoTalkLoginAvailable() {
                UserApi.shared.loginWithKakaoTalk { (oauthToken, error) in
                    guard error == nil,
                          let oauthToken = oauthToken else {
                        observer.onError(TokenError.getToken)
                        return
                    }
                    observer.onNext(oauthToken.accessToken)
                    observer.onCompleted()
                }
            } else {
                UserApi.shared.loginWithKakaoAccount { (oauthToken, error) in
                    guard error == nil,
                            let oauthToken = oauthToken else {
                        observer.onError(TokenError.getToken)
                        return
                    }
                    observer.onNext(oauthToken.accessToken)
                    observer.onCompleted()
                }
            }
            return Disposables.create()
        }
    }
    
    private func googleLogIn() -> Observable<(accessToken: String, idToken: String)> {
        return Observable.create { observer in
            GIDSignIn.sharedInstance.signIn(withPresenting: self) { (result, error) in
                guard error == nil,
                      let result = result,
                      let idToken = result.user.idToken?.tokenString else {
                    observer.onError(TokenError.getToken)
                    return
                }
                observer.onNext((accessToken: result.user.accessToken.tokenString, idToken: idToken))
                observer.onCompleted()
            }
            return Disposables.create()
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
              let identityToken = credential.identityToken else {
            self.failLogInAlert(reason: "")
            return
        }
        let identityTokenString = String(data: identityToken, encoding: .utf8)
        appleLogInResult.accept(identityTokenString ?? "")
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        self.failLogInAlert(reason: "")
    }
}
