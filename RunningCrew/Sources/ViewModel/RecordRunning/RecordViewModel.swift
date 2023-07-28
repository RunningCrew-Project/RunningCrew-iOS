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
    
    struct Input {
        let pauseAndPlayButtonDidTap: Observable<Void>
    }
    
    struct Output {
        let startCount: Observable<Int>
        let isRunning: Observable<Bool>
        let runningSecond: Observable<Float>
        let runningDistance: Observable<Double>
    }
    
    private let locationService: LocationService
    private let motionService: MotionService
    
    private let startCountTimer: Observable<Int> = Observable<Int>.timer(.seconds(1), period: .seconds(1), scheduler: MainScheduler.instance).take(5)
    private var runningInterval: Disposable?
    private let runningSecond: BehaviorRelay<Float> = BehaviorRelay<Float>(value: 0)
    private let runningDistance: BehaviorRelay<Double> = BehaviorRelay<Double>(value: 0.0)
    private var location: [(Double, Double)] = []
    
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
                        .bind { _ in owner.runningSecond.accept(owner.runningSecond.value + 0.2) }
                } else {
                    owner.runningInterval?.dispose()
                }
            }
            .disposed(by: disposeBag)
        
        runningSecond.asObservable()
            .bind { [weak self] second in
                if second.truncatingRemainder(dividingBy: 4.0) == 0 { self?.locationService.updateCoordinate() }
            }
            .disposed(by: disposeBag)
    
        locationService.getCurrentCoordiate()
            .withUnretained(self)
            .bind { (owner, coordinator) in
                if owner.location.isEmpty {
                    owner.location.append((coordinator.latitude, coordinator.longitude))
                } else if owner.isRunning.value {
                    let distance = owner.locationService.distanceBetweenTwoCoordinates(
                        lastLocation: owner.location[owner.location.count - 1],
                        coordinator: coordinator)
                    
                    if distance >= 0.004 {
                        owner.runningDistance.accept(owner.runningDistance.value + distance)
                        owner.location.append((coordinator.latitude, coordinator.longitude))
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
        
        return Output(startCount: startCountTimer,
                      isRunning: isRunning.asObservable(),
                      runningSecond: runningSecond.asObservable(),
                      runningDistance: runningDistance.asObservable())
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

    func pathInformation() -> [(Double, Double)] {
        return location
    }
}
