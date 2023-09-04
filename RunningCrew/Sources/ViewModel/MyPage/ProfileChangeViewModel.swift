//
//  ProfileChangeViewModel.swift
//  RunningCrew
//
//  Created by 김기훈 on 2023/08/13.
//

import Foundation
import RxSwift
import RxRelay

final class ProfileChangeViewModel: BaseViewModelType {
    
    struct Input {
        
    }
    
    struct Output {
        let user: Observable<User?>
    }
    
//    private let name: BehaviorRelay<String> = BehaviorRelay(value: "")
//    private let nickName: BehaviorRelay<String> = BehaviorRelay(value: "")
//    private let dongId: BehaviorRelay<String> = BehaviorRelay(value: "")
//    private let file: BehaviorRelay<String> = BehaviorRelay(value: "")
//    private let newProfileImage: BehaviorRelay<Data> = BehaviorRelay(value: Data())
//    private let sex: BehaviorRelay<String> = BehaviorRelay(value: "")
//    private let birthDay: BehaviorRelay<String> = BehaviorRelay(value: "")
//    private let height: BehaviorRelay<String> = BehaviorRelay(value: "")
//    private let weight: BehaviorRelay<String> = BehaviorRelay(value: "")
    
    private let user: BehaviorRelay<User?> = BehaviorRelay<User?>(value: nil)
    
    private let userService: UserService
    var disposeBag = DisposeBag()
    
    init(userService: UserService, id: Int) {
        self.userService = userService
        
        userService.getProfile(userID: id)
            .subscribe(onNext: { [weak self] user in
                self?.user.accept(user)
            })
            .disposed(by: disposeBag)
    }
    
    func transform(input: Input) -> Output {
        
        return Output(user: user.asObservable())
    }
}
