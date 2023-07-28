//
//  GoalSettingViewModel.swift
//  RunningCrew
//
//  Created by 김기훈 on 2023/07/26.
//

import Foundation
import RxSwift
import RxRelay

final class GoalSettingViewModel: BaseViewModelType {
    
    struct Input {
        let nextButtonDidTap: Observable<Void>
        let beforeButtonDidTap: Observable<Void>
        let textFieldDidChanged: Observable<String?>
        let navigationRightButtonDidTap: Observable<Void>?
    }
    
    struct Output {
        let goalText: Observable<GoalType>
        let goalType: Observable<GoalType>
        let finishSetting: Observable<GoalType>?
    }
    
    private var goalType: BehaviorRelay<GoalType>
    
    var disposeBag = DisposeBag()
    
    init(goalType: GoalType) {
        self.goalType = BehaviorRelay<GoalType>(value: goalType)
    }
    
    func transform(input: Input) -> Output {
        input.nextButtonDidTap
            .withUnretained(self)
            .bind { (owner, _) in owner.goalType.accept(.time(hour: 0, minute: 0)) }
            .disposed(by: disposeBag)
        
        input.beforeButtonDidTap
            .withUnretained(self)
            .bind { (owner, _) in owner.goalType.accept(.distance(kilometer: 0)) }
            .disposed(by: disposeBag)
        
        let goalText = input.textFieldDidChanged
            .withUnretained(self)
            .map { (owner, text) -> GoalType in
                let fourCharacter = text?.prefix(4) ?? "00"
                let text = String(fourCharacter)
                
                switch owner.goalType.value {
                case .distance:
                    let result = owner.setGoalDistance(text: text)
                    owner.goalType.accept(.distance(kilometer: result))
                    return .distance(kilometer: result)
                case .time:
                    let result = owner.setGoalTime(text: text)
                    owner.goalType.accept(.time(hour: result.hour, minute: result.minute))
                    return .time(hour: result.hour, minute: result.minute)
                }
            }
        
        let finishSetting = input.navigationRightButtonDidTap?
            .withUnretained(self)
            .map { (owner, _) in owner.goalType.value }
        
        return Output(goalText: goalText,
                      goalType: goalType.asObservable(),
                      finishSetting: finishSetting)
    }
}

extension GoalSettingViewModel {
    private func setGoalDistance(text: String) -> Float {
        guard let number = Float(text) else {
            return 0
        }
        return number / 100
    }
    
    private func setGoalTime(text: String) -> (hour: Int, minute: Int) {
        guard let number = Int(text) else {
            return (0, 0)
        }
        return (number / 100, number % 100)
    }
    
    func getGoalType() -> GoalType {
        return goalType.value
    }
}
