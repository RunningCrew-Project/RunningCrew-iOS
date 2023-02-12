//
//  TabBarItem.swift
//  RunningCrew
//
//  Created by JunHwan Kim on 2023/02/12.
//

import Foundation

enum TabBarItem: Int {
    case recordRunning = 0
    case crew
    case alarm
    case myPage
    
    func itemTitleValue() -> String {
        switch self {
        case .recordRunning:
            return "러닝기록"
        case .crew:
            return "크루"
        case .alarm:
            return "알림"
        case .myPage:
            return "마이페이지"
        }
    }
    
}
