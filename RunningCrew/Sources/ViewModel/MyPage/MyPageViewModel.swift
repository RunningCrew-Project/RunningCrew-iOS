//
//  MyPageViewModel.swift
//  RunningCrew
//
//  Created by 김기훈 on 2023/07/26.
//

import Foundation
import RxSwift
import RxRelay

final class MyPageViewModel: BaseViewModelType {
    
    struct Input {
        let settingButtonDidTap: Observable<Void>?
        let profileChangeButtonDidTap: Observable<Void>
    }
    
    struct Output {
        let isLogIn: Observable<Bool>
        let me: Observable<Me?>
        let settingButtonResult: Observable<Bool>?
        let profileButtonResult: Observable<Int?>
    }
    
    private let logInService: LogInService
    private let isLogIn: BehaviorRelay<Bool> = BehaviorRelay<Bool>(value: false)
    private let me: BehaviorRelay<Me?> = BehaviorRelay<Me?>(value: nil)
    
    var disposeBag = DisposeBag()
    
    init(logInService: LogInService) {
        self.logInService = logInService
    }
    
    func transform(input: Input) -> Output {
        let settingButtonResult = input.settingButtonDidTap?
            .withUnretained(self)
            .map { (owner, _) in owner.isLogIn.value }
        
        let profileButtonResult = input.profileChangeButtonDidTap
            .withUnretained(self)
            .map { (owner, _) -> Int? in
                return owner.me.value?.id
            }
        
        let isLogIn = logInService.isLogIn
            .map { [weak self] isLogIn -> Bool in
                self?.isLogIn.accept(isLogIn)
                return isLogIn
            }
        
        let me = logInService.me
            .map { [weak self] me -> Me? in
                self?.me.accept(me)
                return me
            }
        
        return Output(isLogIn: isLogIn,
                      me: me,
                      settingButtonResult: settingButtonResult,
                      profileButtonResult: profileButtonResult)
    }
}
