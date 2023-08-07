//
//  RecordViewModel.swift
//  RunningCrew
//
//  Created by JunHwan Kim on 2023/03/04.
//

import Foundation
import CoreLocation
import RxSwift
import RxCocoa

final class RecordViewModel: BaseViewModelType {
    
    typealias RunningData = (distance: Double, milliSeconds: Int, path: [(Double, Double)])
    
    struct Input {
        let pauseAndPlayButtonDidTap: Observable<Void>
        let completeButtonDidTap: Observable<Int>
    }
    
    struct Output {
        let startCount: Observable<Int>
        let isRunning: Observable<Bool>
        let runningMilliSecond: Observable<Int>
        let runningDistance: Observable<Double>
        let runningData: Observable<RunningData?>
    }
    
    private let locationService: LocationService
    private let motionService: MotionService
    
    private let startCountTimer: Observable<Int> = Observable<Int>.timer(.seconds(1), period: .seconds(1), scheduler: MainScheduler.instance).take(5)
    private var runningInterval: Disposable?
    private let runningMilliSecond: BehaviorRelay<Int> = BehaviorRelay<Int>(value: 0)
    private let runningDistance: BehaviorRelay<Double> = BehaviorRelay<Double>(value: 0.0)
    private var path: [(Double, Double)] = []
    private let runningData: BehaviorRelay<RunningData?> = BehaviorRelay<RunningData?>(value: nil)
    
    private let isRunning: BehaviorRelay<Bool> = BehaviorRelay<Bool>(value: false)
    private let goalType: GoalType
    
    var disposeBag = DisposeBag()
    
    init(goalType: GoalType, locationService: LocationService, motionService: MotionService) {
        self.goalType = goalType
        self.locationService = locationService
        self.motionService = motionService
        
        bind()
    }
 
    func bind() {
        startCountTimer
            .subscribe(onCompleted: { [weak self] in
                self?.startRunning()
            })
            .disposed(by: disposeBag)
        
        isRunning.asObservable()
            .withUnretained(self)
            .bind { (owner, isRunning) in
                if isRunning {
                    owner.runningInterval = Observable<Int>.interval(.milliseconds(200), scheduler: MainScheduler.instance)
                        .bind { _ in owner.runningMilliSecond.accept(owner.runningMilliSecond.value + 200) }
                } else {
                    owner.runningInterval?.dispose()
                }
            }
            .disposed(by: disposeBag)
        
        runningMilliSecond.asObservable()
            .withUnretained(self)
            .bind { (owner, milliSeconds) in
                if milliSeconds % 4000 == 0 && owner.motionService.isMoving.value {
                    owner.locationService.updateCoordinate()
                }
                
                switch owner.goalType {
                case .distance(let killometer):
                    if owner.runningDistance.value == killometer { owner.finishRunning() }
                case .time(let hour, let minute):
                    if milliSeconds == ((hour * 3600) + (minute * 60)) * 1000 { owner.finishRunning() }
                }
            }
            .disposed(by: disposeBag)
        
        locationService.getCurrentCoordiate()
            .withUnretained(self)
            .bind { (owner, coordinator) in
                if owner.motionService.isMoving.value == false { return }
                
                if owner.path.isEmpty {
                    owner.path.append((coordinator.latitude, coordinator.longitude))
                } else if owner.isRunning.value {
                    let distance = owner.locationService.distanceBetweenTwoCoordinates(
                        lastLocation: owner.path[owner.path.count - 1],
                        coordinator: coordinator)

                    owner.path.append((coordinator.latitude, coordinator.longitude))
                    
                    if 0.004...0.050 ~= distance {
                        owner.runningDistance.accept(owner.runningDistance.value + distance)
                    }
                }
            }
            .disposed(by: disposeBag)
    }
    
    func transform(input: Input) -> Output {
        input.pauseAndPlayButtonDidTap
            .withUnretained(self)
            .bind { (owner, _) in
                owner.isRunning.value ? owner.stopRunning() : owner.startRunning()
            }
            .disposed(by: disposeBag)
        
        input.completeButtonDidTap
            .withUnretained(self)
            .bind { (owner, _) in
                owner.runningData.accept((distance: owner.runningDistance.value, milliSeconds: owner.runningMilliSecond.value, path: owner.path))
            }
            .disposed(by: disposeBag)
        
        return Output(startCount: startCountTimer,
                      isRunning: isRunning.asObservable(),
                      runningMilliSecond: runningMilliSecond.asObservable(),
                      runningDistance: runningDistance.asObservable(),
                      runningData: runningData.asObservable())
    }
}

extension RecordViewModel {
    private func startRunning() {
        isRunning.accept(true)
        motionService.updateActivityStatus()
    }
    
    private func stopRunning() {
        isRunning.accept(false)
        motionService.stopActivity()
    }
    
    private func finishRunning() {
        runningData.accept((distance: runningDistance.value, milliSeconds: runningMilliSecond.value, path: path))
    }
}
