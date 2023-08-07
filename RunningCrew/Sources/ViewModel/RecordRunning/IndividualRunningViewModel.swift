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

final class IndividualRunningViewModel: BaseViewModelType {
    
    struct Input {
        let goalLabelDidTap: Observable<UITapGestureRecognizer>
        let nextButtonDidTap: Observable<Void>
        let beforeButtonDidTap: Observable<Void>
        let startButtonDidTap: Observable<Void>
        let goalSettingDidChanged: Observable<GoalType>
    }
    
    struct Output {
        let goalType: Observable<GoalType>
        let canStartButton: Observable<(possible: Bool, goalType: GoalType)>
        let location: Observable<(latitude: Double, longitude: Double)>
        let goalSettingType: Observable<GoalType>
        let isLogIn: Bool
    }
    
    private var goalType: BehaviorRelay<GoalType> = BehaviorRelay<GoalType>(value: .distance(kilometer: 5.00))
    private var distanceGoalType: BehaviorRelay<GoalType> = BehaviorRelay<GoalType>(value: .distance(kilometer: 5))
    private var timeGoalType: BehaviorRelay<GoalType> = BehaviorRelay<GoalType>(value: .time(hour: 0, minute: 5))
    
    private let locationService: LocationService
    private let motionService: MotionService
    private let logInService: LogInService
    
    var disposeBag = DisposeBag()
    
    init(locationService: LocationService, motionService: MotionService, logInService: LogInService) {
        self.locationService = locationService
        self.motionService = motionService
        self.logInService = logInService
    }
    
    func transform(input: Input) -> Output {
        input.nextButtonDidTap
            .withUnretained(self)
            .bind { (owner, _) in owner.goalType.accept(owner.timeGoalType.value) }
            .disposed(by: disposeBag)
        
        input.beforeButtonDidTap
            .withUnretained(self)
            .bind { (owner, _) in owner.goalType.accept(owner.distanceGoalType.value) }
            .disposed(by: disposeBag)
        
        input.goalSettingDidChanged
            .withUnretained(self)
            .bind { (owner, newGoalType) in
                switch newGoalType {
                case .distance: owner.distanceGoalType.accept(newGoalType)
                case .time: owner.timeGoalType.accept(newGoalType)
                }
                owner.goalType.accept(newGoalType)
            }
            .disposed(by: disposeBag)
        
        let canStartButton = input.startButtonDidTap
            .throttle(.seconds(1), scheduler: MainScheduler.instance)
            .withUnretained(self)
            .map { (owner, _) -> (possible: Bool, goalType: GoalType) in
                return (owner.motionService.isNeedAuthSetting(), owner.goalType.value)
            }
        
        let location = locationService.getCurrentCoordiate()
            .map { (latitude: $0.latitude, longitude: $0.longitude) }
        
        let goalSettingType = input.goalLabelDidTap
            .withUnretained(self)
            .map { (owner, _) in return owner.goalType.value }
        
        return Output(goalType: goalType.asObservable(),
                      canStartButton: canStartButton,
                      location: location,
                      goalSettingType: goalSettingType,
                      isLogIn: logInService.isLogIn())
    }
}
