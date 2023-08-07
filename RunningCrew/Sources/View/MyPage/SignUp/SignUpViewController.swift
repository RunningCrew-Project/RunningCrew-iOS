//
//  SignUpViewController.swift
//  RunningCrew
//
//  Created by 김기훈 on 2023/07/28.
//

import Foundation
import RxCocoa
import RxSwift

final class SignUpViewController: BaseViewController {
    
    private var signUpView: SignUpView!
    private var viewModel: SignUpViewModel
    
    init(viewModel: SignUpViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.signUpView = SignUpView()
        self.view = signUpView
    }
    
    override func bind() {
        let input = SignUpViewModel.Input(
            nameTextFieldDidChanged: signUpView.nameTextField.rx.text.orEmpty.asObservable(),
            nickNameTextFieldDidChanged: signUpView.nickNameTextField.rx.text.orEmpty.asObservable(),
            signUpButtonDidTap: signUpView.signUpButton.rx.tap.asObservable())
        let output = viewModel.transform(input: input)
        
        output.isNickNamePossible
            .bind { _ in }
            .disposed(by: disposeBag)
        
        output.signUpResult
            .subscribe(onNext: { result in
                print(result)
                print("⭐️")
//                if result {
//                    // 회원가입 성공
//                } else {
//                    // 회원가입 실패
//                }
            }, onError: { error in
                print("에러입니다", error)
            })
            .disposed(by: disposeBag)
    }
}
