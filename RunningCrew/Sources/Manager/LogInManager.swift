//
//  LogInManager.swift
//  RunningCrew
//
//  Created by 김기훈 on 2023/07/21.
//

import Foundation
import RxRelay

final class LogInManager {
    
    static let shared = LogInManager()
    
    private init() { }
    
    let isLogIn: BehaviorRelay<Bool> = BehaviorRelay<Bool>(value: false)
    
    func updateLogInStatus() {
        
    }
}
