//
//  AlarmViewModel.swift
//  RunningCrew
//
//  Created by 김기훈 on 2023/08/09.
//

import Foundation
import RxSwift

final class AlarmViewModel: BaseViewModelType {
    
    struct Input {
        
    }
    
    struct Output {
        let isLogIn: Observable<Bool>
    }
    
    var disposeBag = DisposeBag()
    
    private let logInService = LogInService.shared
    
    func transform(input: Input) -> Output {
        return Output(isLogIn: logInService.isLogIn.asObservable())
    }
}
