//
//  RecordRunningViewModel.swift
//  RunningCrew
//
//  Created by 김기훈 on 2023/07/02.
//

import CoreLocation
import RxSwift
import RxCocoa

final class RecordRunningViewModel: BaseViewModelType {
    
    var disposeBag = DisposeBag()
    
    struct Input {
        let locationButtonDidTap: Observable<Void>
        let individualRunningButtonDidTap: Observable<Void>
        let crewRunningButtonDidTap: Observable<Void>
    }
    
    struct Output {
        let locationInformation: Observable<String>
        let isNeedLocationAuthorization: Observable<Bool>
        let isAvailableIndividualRunning: Observable<Bool>
        let isAvailableCrewRunning: Observable<Bool>
    }
    
    func transform(input: Input) -> Output {
        let locationManager = LocationManager.shared
        
        input.locationButtonDidTap
            .throttle(.seconds(1), scheduler: MainScheduler.instance)
            .bind { _ in
                if locationManager.isNeedLocationAuthorization.value == false {
                    LocationManager.shared.updateLocation()
                }
            }
            .disposed(by: disposeBag)
        
        let isAvailableIndividualRunning = input.individualRunningButtonDidTap
            .map { locationManager.isNeedLocationAuthorization.value }
            
        let isAvailableCrewRunning = input.crewRunningButtonDidTap
            .map { locationManager.isNeedLocationAuthorization.value }
        
        return Output(locationInformation: locationManager.address.asObservable(),
                      isNeedLocationAuthorization: locationManager.isNeedLocationAuthorization.asObservable(),
                      isAvailableIndividualRunning: isAvailableIndividualRunning,
                      isAvailableCrewRunning: isAvailableCrewRunning)
    }
}

