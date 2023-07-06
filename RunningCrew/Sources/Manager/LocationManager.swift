//
//  LocationManager.swift
//  RunningCrew
//
//  Created by 김기훈 on 2023/07/02.
//

import UIKit
import CoreLocation
import RxSwift
import RxCocoa

final class LocationManager: NSObject {
    static let shared = LocationManager()
    
    private let locationManager = CLLocationManager()
    
    var currentCoordinate: BehaviorRelay<CLLocationCoordinate2D> = BehaviorRelay<CLLocationCoordinate2D>(value: CLLocationCoordinate2D(latitude: 37.554763, longitude: 126.97092))
    var address: BehaviorRelay<String> = BehaviorRelay<String>(value: "현 위치를 찾을 수 없습니다.")
    var isNeedLocationAuthorization: BehaviorRelay<Bool> = BehaviorRelay<Bool>(value: false)
    
    private override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }
}

extension LocationManager {
    func updateLocation() {
        locationManager.startUpdatingLocation()
    }
    
    private func reverseGeocode() {
        Task {
            let location = CLLocation(latitude: currentCoordinate.value.latitude, longitude: currentCoordinate.value.longitude)
            let geocoder = CLGeocoder()
            let locale = Locale(identifier: "Ko-kr")
            let placemarks = try await geocoder.reverseGeocodeLocation(location, preferredLocale: locale)

            guard let address = placemarks.last,
                  let locality = address.locality,
                  let subLocality = address.subLocality,
                  let name = address.name else {
                return
            }
            self.address.accept("\(locality) \(subLocality) \(name)")
        }
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let coordinate = manager.location?.coordinate else { return }
        currentCoordinate.accept(coordinate)
        reverseGeocode()
        self.locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        self.address.accept("현 위치를 찾을 수 없습니다.")
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            isNeedLocationAuthorization.accept(false)
        case .denied, .restricted, .notDetermined:
            isNeedLocationAuthorization.accept(true)
        @unknown default:
            return
        }
    }
}
