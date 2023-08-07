//
//  SignUpViewModel.swift
//  RunningCrew
//
//  Created by 김기훈 on 2023/07/28.
//

import Foundation
import RxSwift

final class SignUpViewModel: BaseViewModelType {
    
    struct Input {
        let nameTextFieldDidChanged: Observable<String>
        let nickNameTextFieldDidChanged: Observable<String>
        
        let signUpButtonDidTap: Observable<Void>
    }
    
    struct Output {
        let isNickNamePossible: Observable<Bool>
        let signUpResult: Observable<User>
    }
    
    private let logInService: LogInService
    private let accessToken: String
    private let refreshToken: String
    
    private var name: String = ""
    private var nickName: String = ""
    
    var disposeBag = DisposeBag()
    
    init(logInService: LogInService, accessToken: String, refreshToken: String) {
        self.logInService = logInService
        self.accessToken = accessToken
        self.refreshToken = refreshToken
    }
    
    func transform(input: Input) -> Output {
        input.nameTextFieldDidChanged
            .bind { [weak self] name in self?.name = name }
            .disposed(by: disposeBag)
        
        let isNickNamePossible = input.nickNameTextFieldDidChanged
            .withUnretained(self)
            .map { (owner, nickName) -> Bool in
                owner.nickName = nickName
                return 2...8 ~= nickName.count
            }
        
        let signUpResult = input.signUpButtonDidTap
            .withUnretained(self)
            .flatMap { (owner, _) in
                return owner.logInService.signUp(accessToken: owner.accessToken, name: owner.name, nickName: owner.nickName, dongId: 1, birthday: "2023-08-07", sex: "MAN", height: 180, weight: 80)
            }
//            .map { user in
//                //user 저장
//
//                return
//            }
            
        return Output(isNickNamePossible: isNickNamePossible,
                      signUpResult: signUpResult)
    }
}
