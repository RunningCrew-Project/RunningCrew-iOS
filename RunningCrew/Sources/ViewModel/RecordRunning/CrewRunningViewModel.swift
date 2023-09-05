//
//  CrewRunningViewModel.swift
//  RunningCrew
//
//  Created by 김기훈 on 2023/08/07.
//

import Foundation
import RxSwift

final class CrewRunningViewModel: BaseViewModelType {
    
    struct Input {
        
    }
    
    struct Output {
        let crews: Observable<[Crew]>
    }
    
    private let runningService: RunningService
    
    var disposeBag = DisposeBag()
    
    init(runningService: RunningService) {
        self.runningService = runningService
    }
    
    func transform(input: Input) -> Output {
        return Output(crews: runningService.getMyCrewRunning())
    }
}
