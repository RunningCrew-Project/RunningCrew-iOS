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
    }
    
    struct Output {
        let user: Observable<User?>
        let isLogIn: Observable<Bool>
    }
    
    private let logInService: LogInService
    
    private let user: BehaviorRelay<User?> = BehaviorRelay<User?>(value: nil)
    private let isLogIn: BehaviorRelay<Bool> = BehaviorRelay<Bool>(value: false)
    
    var disposeBag = DisposeBag()
    
    init(logInService: LogInService) {
        self.logInService = logInService
        isLogIn.accept(logInService.isLogIn())
    }
    
    func transform(input: Input) -> Output {
        
        return Output(user: user.asObservable(),
                      isLogIn: isLogIn.asObservable()
        )
    }
}
