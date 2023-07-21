//
//  MotionManager.swift
//  RunningCrew
//
//  Created by 김기훈 on 2023/07/14.
//

import Foundation
import CoreMotion
import RxSwift
import RxRelay

final class MotionManager {
    static let shared = MotionManager()
    
    private let motionActivityManager = CMMotionActivityManager()
    
    let isMoving = BehaviorRelay<Bool>(value: false)
    
    private init() { }
    
    func isNeedAuthSetting() -> Bool {
        switch CMMotionActivityManager.authorizationStatus() {
        case .authorized: return false
        case .denied, .restricted, .notDetermined: return true
        @unknown default: return true
        }
    }
    
    func updateActivityStatus() {
        self.motionActivityManager.startActivityUpdates(to: .main) { activity in
            guard let activity = activity else {
                return
            }
            if activity.running || activity.walking {
                self.isMoving.accept(true)
            } else {
                self.isMoving.accept(false)
            }
        }
    }
    
    func stopActivity() {
        self.motionActivityManager.stopActivityUpdates()
    }
}
