//
//  RecordViewModel.swift
//  RunningCrew
//
//  Created by JunHwan Kim on 2023/03/04.
//

import Foundation
import RxSwift
import RxCocoa

final class RecordViewModel: BaseViewModelType {
    
    //MARK: - Timer Properties
    private var runningHour: Int = 0
    private var runningMinute: Int = 0
    private var runningSecond: Float = 0
    private var timer: Timer?
    private var location: [(Double, Double)] = []

    private let timerText: BehaviorRelay<String> = BehaviorRelay(value: "00:00:00")
    private let runningDistance: BehaviorRelay<Double> = BehaviorRelay(value: 0.0)
    private let isRunning: BehaviorRelay<Bool> = BehaviorRelay<Bool>(value: false)
    var disposeBag = DisposeBag()
    private let goalType: GoalType
    private let goal: String
    
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
        
        bind()
    }
    
    func transform(input: Input) -> Output {
        input.pauseAndPlayButtonDidTap
            .bind { self.isRunning.value ? self.stopTimer() : self.startTimer() }
            .disposed(by: disposeBag)
        
        return Output(isRunning: isRunning.asObservable(),
                      timerText: timerText.asDriver(onErrorJustReturn: ""),
                      runningDistance: runningDistance.map { String(format: "%.2f", $0) }.asDriver(onErrorJustReturn: ""))
    }
    
    func startTimer() {
        isRunning.accept(true)
        
        timer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(timerCallBack), userInfo: nil, repeats: true)
    }
    
    func stopTimer() {
        isRunning.accept(false)
        timer?.invalidate()
    }
    
    func deinitViewModel() {
        self.timer?.invalidate()
        self.timer = nil
    }
    
    @objc private func timerCallBack() {
        runningSecond += 0.2
        if runningSecond == 60 {
            runningSecond = 0
            runningMinute += 1
            if runningMinute == 60 {
                runningMinute = 0
                runningHour += 1
            }
        }
        timerText.accept("\(String(format: "%02d", runningHour)):\(String(format: "%02d", runningMinute)):\(String(format: "%02d", Int(runningSecond)))")
    }
    
    deinit {
        print("deinit record viewModel")
    }
    
    private func degreesToRadians(_ degrees: Double) -> Double {
        return degrees * .pi / 180.0
    }
    
    func bind() {
        Observable<Int>.timer(.seconds(4), period: .seconds(4), scheduler: MainScheduler.instance)
            .subscribe { _ in LocationManager.shared.updateLocation() }
            .disposed(by: disposeBag)
        
        LocationManager.shared.currentCoordinate.asObservable()
            .bind { coordinator in
                if self.location.isEmpty {
                    self.location.append((coordinator.latitude, coordinator.longitude))
                } else if self.isRunning.value {
                    let lastLocation = self.location[self.location.count - 1]
                    
                    let dLat = self.degreesToRadians(coordinator.latitude - lastLocation.0)
                    let dLon = self.degreesToRadians(coordinator.longitude - lastLocation.1)
                    
                    let a = sin(dLat/2) * sin(dLat/2) + cos(self.degreesToRadians(coordinator.latitude)) * cos(self.degreesToRadians(lastLocation.0)) * sin(dLon/2) * sin(dLon/2)
                    
                    let c = 2 * atan2(sqrt(a), sqrt(1-a))
                    let distance = 6371 * c
                    
                    if distance >= 0.010 {
                        self.runningDistance.accept(self.runningDistance.value + distance)
                        self.location.append((coordinator.latitude, coordinator.longitude))
                        print(distance)
                    }
                }
            }
            .disposed(by: disposeBag)
    }
}
