//
//  CrewViewModel.swift
//  RunningCrew
//
//  Created by 김기훈 on 2023/08/07.
//

import Foundation
import RxSwift

final class CrewViewModel: BaseViewModelType {
    
    struct Input {
        let leftBarButtonItemDidTap: Observable<Void>?
        let rightBarButtonItemDidTap: Observable<Void>?
    }
    
    struct Output {
        let isLogIn: Observable<Bool>
        let myCrew: Observable<[Crew]>
        let recommendCrew: Observable<[GuRecommendCrew]>
        let address: Observable<String>
        let generateCrewResult: Observable<Bool>?
        let searchCrewResult: Observable<Bool>?
    }
    
    private let logInService: LogInService
    private let runningService: RunningService
    private let locationService: LocationService
    
    var disposeBag = DisposeBag()
    
    init(logInService: LogInService, runningService: RunningService, locationService: LocationService) {
        self.logInService = logInService
        self.runningService = runningService
        self.locationService = locationService
    }
    
    func transform(input: Input) -> Output {
        let generateCrewResult = input.leftBarButtonItemDidTap?
            .withUnretained(self)
            .map { (owner, _) in return owner.logInService.isLogIn.value }
        
        let searchCrewResult = input.rightBarButtonItemDidTap?
            .withUnretained(self)
            .map { (owner, _) in return owner.logInService.isLogIn.value }
        
        let recommendCrew = locationService.getCurrentAddress()
            .withUnretained(self)
            .flatMap { (owner, address) -> Observable<GuID> in
                let gu = address.components(separatedBy: " ")[...1].joined(separator: " ")
                return owner.locationService.getGuID(keyword: gu)
            }
            .withUnretained(self)
            .flatMap { (owner, guID) -> Observable<[GuRecommendCrew]> in
                return owner.runningService.getRecommendCrew(guID: guID.id)
            }
        
        return Output(isLogIn: logInService.isLogIn.asObservable(),
                      myCrew: runningService.getMyCrewRunning(),
                      recommendCrew: recommendCrew,
                      address: locationService.getCurrentAddress(),
                      generateCrewResult: generateCrewResult,
                      searchCrewResult: searchCrewResult
        )
    }
}
