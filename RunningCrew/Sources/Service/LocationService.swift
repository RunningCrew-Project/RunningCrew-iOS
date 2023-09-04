//
//  LocationManager.swift
//  RunningCrew
//
//  Created by 김기훈 on 2023/07/02.
//

import UIKit
import CoreLocation
import RxSwift
import RxRelay

final class LocationService: NSObject {
    
    private let locationManager = CLLocationManager()
    
    private var areaRepository: AreaRepository
    private var currentCoordinate: BehaviorRelay<CLLocationCoordinate2D> = BehaviorRelay<CLLocationCoordinate2D>(value: CLLocationCoordinate2D(latitude: 37.554763,
        longitude: 126.97092))
    private var currentAddress: BehaviorRelay<String> = BehaviorRelay<String>(value: "현 위치를 찾을 수 없습니다.")
    
    init(areaRepository: AreaRepository) {
        self.areaRepository = areaRepository
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }
}

extension LocationService {
    func updateCoordinate() {
        locationManager.startUpdatingLocation()
    }
    
    func getCurrentCoordiate() -> Observable<CLLocationCoordinate2D> {
        return currentCoordinate.asObservable()
    }
    
    func getCurrentAddress() -> Observable<String> {
        return currentAddress.asObservable()
    }
    
    func isNeedAuthorization() -> Bool {
        if locationManager.authorizationStatus == .authorizedAlways || locationManager.authorizationStatus == .authorizedWhenInUse {
            return false
        } else {
            return true
        }
    }
    
    func distanceBetweenTwoCoordinates(lastLocation: (Double, Double), coordinator: CLLocationCoordinate2D) -> Double {
            let latitudeRadian = (coordinator.latitude - lastLocation.0) * .pi / 180.0
            let longitudeRadian = (coordinator.longitude - lastLocation.1) * .pi / 180.0
            
            let intermediateCalculation = sin(latitudeRadian/2) * sin(latitudeRadian/2) + cos(coordinator.latitude * .pi / 180.0) * cos(lastLocation.0 * .pi / 180.0) * sin(longitudeRadian/2) * sin(longitudeRadian/2)
            let distance = 6371 * 2 * atan2(sqrt(intermediateCalculation), sqrt(1-intermediateCalculation))
            
           return distance
    }
    
    private func reverseGeocode(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let location = CLLocation(latitude: latitude, longitude: longitude)
        let geocoder = CLGeocoder()
        let locale = Locale(identifier: "Ko-kr")
        
        geocoder.reverseGeocodeLocation(location, preferredLocale: locale) { [weak self] placemarks, error in
            guard error == nil,
                  let address = placemarks?.last?.description.components(separatedBy: ", "),
                  address.count >= 2
            else {
                self?.currentAddress.accept("현 위치를 찾을 수 없습니다.")
                return
            }
    
            let fullAddress = address[1].components(separatedBy: " ")[1...].joined(separator: " ")
            
            self?.currentAddress.accept(fullAddress)
        }
    }
}

extension LocationService: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let coordinate = manager.location?.coordinate else { return }
        currentCoordinate.accept(coordinate)
        reverseGeocode(latitude: coordinate.latitude, longitude: coordinate.longitude)
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        currentCoordinate.accept(CLLocationCoordinate2D(latitude: 37.554763,
                                                        longitude: 126.97092))
        currentAddress.accept("현 위치를 찾을 수 없습니다.")
    }
}

extension LocationService {
    func getSi() -> Observable<SiDo> {
        return areaRepository.getSi()
            .map { try JSONDecoder().decode(SiDo.self, from: $0) }
    }
    
    func getGu(siID: Int) -> Observable<Gu> {
        return areaRepository.getGu(siID: siID)
            .map { try JSONDecoder().decode(Gu.self, from: $0) }
    }
    
    func getDong(guID: Int) -> Observable<Dong> {
        return areaRepository.getDong(guID: guID)
            .map { try JSONDecoder().decode(Dong.self, from: $0) }
    }
    
    func getGuID(keyword: String) -> Observable<GuID> {
        return areaRepository.getGuID(keyword: keyword)
            .map { try JSONDecoder().decode(GuID.self, from: $0) }
    }
}
