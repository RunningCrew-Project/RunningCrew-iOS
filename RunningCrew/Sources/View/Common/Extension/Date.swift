//
//  Date.swift
//  RunningCrew
//
//  Created by 김기훈 on 2023/08/09.
//

import Foundation

extension Date {
    func addingMonths(_ months: Int) -> Date? {
        let calendar = Calendar.current
        var components = DateComponents()
        components.month = months
        return calendar.date(byAdding: components, to: self)
    }
}
