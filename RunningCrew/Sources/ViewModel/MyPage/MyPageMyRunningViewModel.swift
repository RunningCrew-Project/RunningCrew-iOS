//
//  MyPageMyRunningViewModel.swift
//  RunningCrew
//
//  Created by 김기훈 on 2023/08/09.
//

import Foundation
import RxSwift
import RxRelay

final class MyPageMyRunningViewModel: BaseViewModelType {
    
    struct Input {
        
    }
    
    struct Output {
        let allRunningRecord: Observable<[AllRunningRecordContent]>
    }
    
    private let runningService: RunningService
    private let logInServie: LogInService = LogInService.shared
    
    private let runningRecord: BehaviorRelay<[AllRunningRecordContent]> = BehaviorRelay(value: [])
    
    var disposeBag = DisposeBag()
    
    init(runningService: RunningService) {
        self.runningService = runningService
        getRunningRecord()
    }
    
    func transform(input: Input) -> Output {
        return Output(allRunningRecord:
                        runningRecord.asObservable())
    }
}

extension MyPageMyRunningViewModel {
    private func getRunningRecord() {
        logInServie.me
            .withUnretained(self)
            .flatMap { (owner, me) -> Observable<[AllRunningRecordContent]> in
                guard let me = me else { return Observable.empty() }
                return owner.runningService.getAllMyRunningRecord(userID: me.id, page: 0)
            }
            .withUnretained(self)
            .subscribe(onNext: { (owner, data) in
                owner.runningRecord.accept(owner.runningRecord.value + data)
            })
            .disposed(by: disposeBag)
    }
}
