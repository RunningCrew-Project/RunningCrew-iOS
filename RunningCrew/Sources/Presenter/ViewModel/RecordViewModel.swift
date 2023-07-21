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
    
    //MARK: - Timer Properties
    private var runningHour: Int = 0
    private var runningMinute: Int = 0
    private var runningSecond: Float = 0
    private var timer: Disposable?
    private var location: [(Double, Double)] = []

    private let timerText: BehaviorRelay<String> = BehaviorRelay(value: "00:00:00")
    private let runningDistance: BehaviorRelay<Double> = BehaviorRelay(value: 0.0)
    private let isRunning: BehaviorRelay<Bool> = BehaviorRelay<Bool>(value: false)
    private let goalType: GoalType
    private let goal: String
    
    var disposeBag = DisposeBag()
    
    struct Input {
        let pauseAndPlayButtonDidTap: Observable<Void>
    }
    
    struct Output {
        let isRunning: Observable<Bool>
        let timerText: Driver<String>
        let runningDistance: Driver<String>
    }
    
    init(goalType: GoalType, goal: String) {
        self.goalType = goalType
        self.goal = goal
    }
    
    func transform(input: Input) -> Output {
        Observable<Int>.timer(.seconds(4), period: .seconds(4), scheduler: MainScheduler.instance)
            .subscribe { _ in
                if MotionManager.shared.isMoving.value == false {
                    return
                }
                LocationManager.shared.updateLocation()
            }
            .disposed(by: disposeBag)
        
        LocationManager.shared.currentCoordinate.asObservable()
            .bind { [weak self] coordinator in
                guard let self = self else { return }
                
                if self.location.isEmpty {
                    self.location.append((coordinator.latitude, coordinator.longitude))
                } else if self.isRunning.value {
                    let distance = LocationManager.shared.distanceBetweenTwoCoordinates(
                        lastLocation: self.location[self.location.count - 1],
                        coordinator: coordinator)
                    
                    if distance >= 0.004 {
                        self.runningDistance.accept(self.runningDistance.value + distance)
                        self.location.append((coordinator.latitude, coordinator.longitude))
                    }
                }
            }
            .disposed(by: disposeBag)
        
        input.pauseAndPlayButtonDidTap
            .bind { _ in
                if self.isRunning.value {
                    self.stopRunning()
                } else {
                    self.startRunning()
                }
            }
            .disposed(by: disposeBag)
        
        return Output(isRunning: isRunning.asObservable(),
                      timerText: timerText.asDriver(onErrorJustReturn: ""),
                      runningDistance: runningDistance.map { String(format: "%.2f", $0) }.asDriver(onErrorJustReturn: ""))
    }
    
    func startRunning() {
        isRunning.accept(true)
        MotionManager.shared.updateActivityStatus()
        
        timer = nil
        timer = Observable<Int>.interval(.milliseconds(250), scheduler: MainScheduler.instance).subscribe(onNext: { [weak self] _ in
            self?.timerCallBack()
        })
        
        timer?.disposed(by: disposeBag)
    }
    
    func stopRunning() {
        isRunning.accept(false)
        MotionManager.shared.stopActivity()
        timer?.dispose()
    }
    
    deinit {
        timer?.dispose()
        self.timer = nil
        print("deinit record viewModel")
    }
}

extension RecordViewModel {
    private func timerCallBack() {
        runningSecond += 0.25
        if runningSecond == 60 {
            runningSecond = 0
            runningMinute += 1
            if runningMinute == 60 {
                runningMinute = 0
                runningHour += 1
            }
        }
        timerText.accept("\(String(format: "%02d", runningHour)):\(String(format: "%02d", runningMinute)):\(String(format: "%02d", Int(runningSecond.rounded())))")
    }
    
    func pathInformation() -> [(Double, Double)] {
        return location
    }
}
