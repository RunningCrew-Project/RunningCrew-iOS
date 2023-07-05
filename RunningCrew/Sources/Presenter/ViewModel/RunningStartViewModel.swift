//
//  RunningStartViewModel.swift
//  RunningCrew
//
//  Created by JunHwan Kim on 2023/03/01.
//

import Foundation
import RxCocoa
import RxSwift
import RxRelay

final class RunningStartViewModel: BaseViewModelType {
    
    var goalType: BehaviorRelay<GoalType> = BehaviorRelay<GoalType>(value: .distance)
    var goalDistance: BehaviorRelay<Float> = BehaviorRelay<Float>(value: 5.00)
    var goalHour: BehaviorRelay<Int> = BehaviorRelay<Int>(value: 0)
    var goalMinute: BehaviorRelay<Int> = BehaviorRelay<Int>(value: 0)
    
    var disposeBag = DisposeBag()
    
    struct Input {
        let nextButtonDidTap: Observable<Void>
        let beforeButtonDidTap: Observable<Void>
        let navigationRightButtonDidTap: Observable<String>?
    }
    
    struct Output {
        let goalText: Driver<String>
    }
    
    func transform(input: Input) -> Output {
        input.nextButtonDidTap
            .bind { self.goalType.accept(.time) }
            .disposed(by: disposeBag)
        
        input.beforeButtonDidTap
            .bind { self.goalType.accept(.distance) }
            .disposed(by: disposeBag)
        
        input.navigationRightButtonDidTap?
            .bind { [weak self] text in
                guard let self = self else { return }
                
                switch goalType.value {
                case .distance:
                    goalDistance.accept(Float(text) ?? 0)
                case .time:
                    let time = (text).split(separator: ":").map {Int($0)}
                    
                    goalHour.accept(time[0] ?? 0 )
                    goalMinute.accept(time[1] ?? 0)
                }
            }
            .disposed(by: disposeBag)
        
        let goalText = Observable.combineLatest(goalType, goalDistance, goalHour, goalMinute)
            .map { type, distance, hour, minute in
                switch type {
                case .distance: return String(format: "%.2f", distance)
                case .time: return String(format: "%.2d", hour) + ":" + String(format: "%.2d", minute)
                }
            }
            .asDriver(onErrorJustReturn: "")
        
        return Output(goalText: goalText)
    }
}
