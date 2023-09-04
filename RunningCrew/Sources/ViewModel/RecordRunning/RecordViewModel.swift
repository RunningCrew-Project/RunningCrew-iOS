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
        let completeButtonDidTap: Observable<Int>
    }
    
    struct Output {
        let startCount: Observable<Int>
        let isRunning: Observable<Bool>
        let runningMilliSecond: Observable<Int>
        let runningDistance: Observable<Double>
        let runningData: Observable<RunningRecord>
    }
    
    private let locationService: LocationService
    private let motionService: MotionService
    
    private let startTime = Date()
    private var startLocation: String = ""
    private let startCountTimer: Observable<Int> = Observable<Int>.timer(.seconds(1), period: .seconds(1), scheduler: MainScheduler.instance).take(5)
    private var runningInterval: Disposable?
    private let runningMilliSecond: BehaviorRelay<Int> = BehaviorRelay<Int>(value: 0)
    private let runningDistance: BehaviorRelay<Double> = BehaviorRelay<Double>(value: 0.0)
    private var path: [(Double, Double)] = []
    private let currentPace: BehaviorRelay<Double> = BehaviorRelay<Double>(value: 0.0)
    private var currentPaceTime: BehaviorRelay<Int> = BehaviorRelay<Int>(value: 0)
    private let averagePage: BehaviorRelay<Double> = BehaviorRelay<Double>(value: 0.0)
    
    private let runningData: PublishRelay<RunningRecord> = PublishRelay()
    
    private let isRunning: BehaviorRelay<Bool> = BehaviorRelay<Bool>(value: false)
    private let goalType: GoalType
    
    var disposeBag = DisposeBag()
    
    init(goalType: GoalType, locationService: LocationService, motionService: MotionService) {
        self.goalType = goalType
        self.locationService = locationService
        self.motionService = motionService
        
        bind()
    }
 
    private func bind() {
        startCountTimer
            .subscribe(onCompleted: { [weak self] in
                guard let self = self else { return }
                
                self.locationService.getCurrentAddress()
                    .subscribe(onNext: { location in
                        self.startLocation = location
                    })
                    .disposed(by: disposeBag)
                    
                self.startRunning()
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
                owner.secondDidChanged(milliSecond: milliSeconds)
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
                        if floor(owner.runningDistance.value + distance) == ceil(owner.runningDistance.value) {
                            owner.currentPaceTime.accept(owner.runningMilliSecond.value)
                        }
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
            .subscribe(onNext: { (owner, _) in
                owner.finishRunning()
            })
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
    
    private func secondDidChanged(milliSecond: Int) {
        if milliSecond % 4000 == 0 && motionService.isMoving.value {
            locationService.updateCoordinate()
        }
        
        if milliSecond % 10000 == 0 {
            let restDistance = self.runningDistance.value - floor(self.runningDistance.value)
            let restTime = self.runningMilliSecond.value - self.currentPaceTime.value
            
            self.currentPace.accept(restDistance / Double(restTime / 1000))
        }
        
        averagePage.accept(runningDistance.value / (Double(milliSecond) / 60000))
        
        switch goalType {
        case .distance(let killometer):
            if runningDistance.value == killometer { finishRunning() }
        case .time(let hour, let minute):
            if milliSecond == ((hour * 3600) + (minute * 60)) * 1000 { finishRunning() }
        }
    }
    
    private func finishRunning() {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.dateFormat = "YYYY-MM-dd HH:mm"
        let date = dateFormatter.string(from: startTime)
        
        // TODO: 칼로리
        
        let runningRecord = RunningRecord(startDateTime: date, location: startLocation, runningDistance: runningDistance.value, runningTime: runningMilliSecond.value / 1000, runningPace: Int(averagePage.value) + 1, calories: 1, runningDetails: "", gps: path.map {GPSPoint(latitude: $0.0, longitude: $0.1)}, files: [], runningNoticeId: nil)
        
        runningData.accept(runningRecord)
    }
}
