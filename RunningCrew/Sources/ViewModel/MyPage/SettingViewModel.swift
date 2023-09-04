//
//  SettingViewModel.swift
//  RunningCrew
//
//  Created by 김기훈 on 2023/08/10.
//

import Foundation
import RxSwift

final class SettingViewModel: BaseViewModelType {
    
    struct Input {
        let logOutButtonDidTap: Observable<Void>
        let withDrawalDidTap: Observable<Void>
    }
    
    struct Output {
        let isSuccessLogOut: Observable<Bool>
        let isSuccessWithDrawal: Observable<Bool>
        let isLogIn: Observable<Bool>
    }
    
    private let logInService = LogInService.shared
    
    var disposeBag = DisposeBag()
    
    func transform(input: Input) -> Output {
        let isSuccessLogOut = input.logOutButtonDidTap
            .withUnretained(self)
            .map { (owner, _) -> Bool in
                return owner.logInService.logOut()
            }
        
        let isSuccessWithDrawal = input.withDrawalDidTap
            .withUnretained(self)
            .flatMap { (owner, _) -> Observable<Bool> in
                return owner.logInService.withDrawal()
            }
            
        return Output(isSuccessLogOut: isSuccessLogOut,
                      isSuccessWithDrawal: isSuccessWithDrawal,
                      isLogIn: logInService.isLogIn.asObservable()
        )
    }
}
