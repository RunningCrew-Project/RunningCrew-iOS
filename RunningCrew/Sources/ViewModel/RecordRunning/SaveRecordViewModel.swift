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
    }
    
    struct Output {
        let location: Observable<(latitude: Double, longitude: Double)>
        let photos: Observable<[Data]>
        let isLogIn: Bool
        let distance: Double
        let milliSeconds: Int
        let path: [(Double, Double)]
        let date: String
    }
    
    private let locationService: LocationService
    private let logInService: LogInService
    
    private let currentTime = Date()
    private let distance: Double
    private let milliSeconds: Int
    private let path: [(Double, Double)]
    
    private let photos: BehaviorRelay<[Data]> = BehaviorRelay<[Data]>(value: [])
    private let content: BehaviorRelay<String> = BehaviorRelay<String>(value: "")
    
    var disposeBag = DisposeBag()
    
    init(path: [(Double, Double)], distance: Double, milliSeconds: Int, locationService: LocationService, logInService: LogInService) {
        self.path = path
        self.distance = distance
        self.milliSeconds = milliSeconds
        self.locationService = locationService
        self.logInService = logInService
    }
    
    func transform(input: Input) -> Output {
        input.textFieldDidChanged
            .bind(to: content)
            .disposed(by: disposeBag)
        
        input.photos
            .bind(to: photos)
            .disposed(by: disposeBag)
        
        let location = locationService.getCurrentCoordiate()
            .map { (latitude: $0.latitude, longitude: $0.longitude) }
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.dateFormat = "YYYY년 M월 d일 h:mm"
        let date = dateFormatter.string(from: currentTime)
        
        return Output(location: location,
                      photos: photos.asObservable(),
                      isLogIn: logInService.isLogIn(),
                      distance: distance,
                      milliSeconds: milliSeconds,
                      path: path,
                      date: date)
    }
}
