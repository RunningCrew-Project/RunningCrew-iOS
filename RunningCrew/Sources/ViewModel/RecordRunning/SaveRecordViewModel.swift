//
//  SaveRecordViewModel.swift
//  RunningCrew
//
//  Created by 김기훈 Kim on 2023/07/15.
//

import UIKit
import RxSwift
import RxRelay

final class SaveRecordViewModel: BaseViewModelType {
    
    struct Input {
        let textFieldDidChanged: Observable<String>
        let photos: Observable<[Data]>
        let confirmSaveRecord: Observable<Void>
    }
    
    struct Output {
        let location: Observable<(latitude: Double, longitude: Double)>
        let photos: Observable<[Data]>
        let isLogIn: Bool
        let runningRecord: RunningRecord
        let isSuccessSaveRecord: Observable<Bool>
    }
    
    private let locationService: LocationService
    private let logInService: LogInService
    private let runningService: RunningService
    
    private let currentTime = Date()
    private var runningRecord: RunningRecord
    
    private let photos: BehaviorRelay<[Data]> = BehaviorRelay<[Data]>(value: [])
    private let content: BehaviorRelay<String> = BehaviorRelay<String>(value: "")
    private let isSuccessSaveRecord: PublishRelay<Bool> = PublishRelay()
    
    var disposeBag = DisposeBag()
    
    init(runningRecord: RunningRecord, locationService: LocationService, logInService: LogInService, runningService: RunningService) {
        self.runningRecord = runningRecord
        self.locationService = locationService
        self.logInService = logInService
        self.runningService = runningService
    }
    
    func transform(input: Input) -> Output {
        input.textFieldDidChanged
            .subscribe(onNext: { [weak self] text in
                self?.runningRecord.runningDetails = text
            })
            .disposed(by: disposeBag)
        
        input.photos
            .subscribe(onNext: { [weak self] photos in
                self?.runningRecord.files = photos
            })
            .disposed(by: disposeBag)
        
        input.confirmSaveRecord
            .withUnretained(self)
            .flatMap { (owner, _) -> Observable<Bool> in
                return owner.runningService.createPersonalRunningRecord(data: owner.runningRecord)
            }
            .subscribe(onNext: { [weak self] result in
                self?.isSuccessSaveRecord.accept(result)
            }, onError: { [weak self] _ in
                self?.isSuccessSaveRecord.accept(false)
            })
            .disposed(by: disposeBag)
        
        let location = locationService.getCurrentCoordiate()
            .map { (latitude: $0.latitude, longitude: $0.longitude) }
        
        return Output(location: location,
                      photos: photos.asObservable(),
                      isLogIn: logInService.isLogIn.value,
                      runningRecord: runningRecord,
                      isSuccessSaveRecord: isSuccessSaveRecord.asObservable())
    }
}
