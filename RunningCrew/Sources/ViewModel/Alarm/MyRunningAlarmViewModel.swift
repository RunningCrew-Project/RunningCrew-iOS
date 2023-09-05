//
//  MyRunningAlarmViewModel.swift
//  RunningCrew
//
//  Created by 김기훈 on 2023/08/23.
//

import Foundation
import RxSwift

final class MyRunningAlarmViewModel: BaseViewModelType {
    
    struct Input {
        
    }
    
    struct Output {
        let runningNotices: Observable<RunningNotices>
    }
    
    private let alarmService: AlarmService
    var disposeBag = DisposeBag()
    
    init(alarmService: AlarmService) {
        self.alarmService = alarmService
    }
    
    func transform(input: Input) -> Output {
        return Output(runningNotices: alarmService.getNotice())
    }
}
