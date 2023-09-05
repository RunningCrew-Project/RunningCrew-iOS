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
    
    struct Input {
        let locationButtonDidTap: Observable<Void>
        let individualRunningButtonDidTap: Observable<Void>
        let crewRunningButtonDidTap: Observable<Void>
    }
    
    struct Output {
        let isLogIn: Observable<Bool>
        let currentAddress: Observable<String>
        let needAction: Observable<Actiontype>
    }
    
    enum Actiontype {
        case locationButton
        case individualRunning
        case crewRunning
        case needAuthorizationAlert
        case needLogIn
    }
    
    private let logInService: LogInService
    private let locationService: LocationService
    
    var disposeBag = DisposeBag()
    
    init(logInService: LogInService, locationService: LocationService) {
        self.logInService = logInService
        self.locationService = locationService
    }
    
    func transform(input: Input) -> Output {
        let locationButtonDidTap = input.locationButtonDidTap
            .throttle(.seconds(1), scheduler: MainScheduler.instance)
            .withUnretained(self)
            .map { (owner, _) -> Actiontype in
                owner.locationService.updateCoordinate()
                return owner.locationService.isNeedAuthorization() ? .needAuthorizationAlert : .locationButton
            }
        
        let individualRunningButtonDidTap = input.individualRunningButtonDidTap
            .throttle(.seconds(1), scheduler: MainScheduler.instance)
            .withUnretained(self)
            .map {  (owner, _) -> Actiontype in
                return owner.locationService.isNeedAuthorization() ? .needAuthorizationAlert : .individualRunning
            }
        
        let crewRunningButtonDidTap = input.crewRunningButtonDidTap
            .throttle(.seconds(1), scheduler: MainScheduler.instance)
            .withUnretained(self)
            .map {  (owner, _) -> Actiontype in
                if owner.locationService.isNeedAuthorization() {
                    return .needAuthorizationAlert
                } else if owner.logInService.isLogIn.value == false {
                    return .needLogIn
                } else {
                    return .crewRunning
                }
            }
        
        return Output(isLogIn: logInService.isLogIn.asObservable(),
                      currentAddress: locationService.getCurrentAddress(),
                      needAction: Observable.merge(locationButtonDidTap,
                                                   individualRunningButtonDidTap,
                                                   crewRunningButtonDidTap))
    }
}
