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
    }
    
    struct Output {
        let isNeedLocationAuth: Observable<Bool>
        let locationInformation: Observable<String>
    }
    
    func transform(input: Input) -> Output {
        input.locationButtonDidTap
            .throttle(.seconds(1), scheduler: MainScheduler.instance)
            .bind { LocationManager.shared.updateLocation() }
            .disposed(by: disposeBag)
        
        let locationManager = LocationManager.shared
        
        return Output(isNeedLocationAuth: locationManager.isNeedLocationAuthorization.asObservable(),
                      locationInformation: locationManager.address.asObservable())
    }
}

