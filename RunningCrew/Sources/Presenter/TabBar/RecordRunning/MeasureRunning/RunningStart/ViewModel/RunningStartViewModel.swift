//
//  RunningStartViewModel.swift
//  RunningCrew
//
//  Created by JunHwan Kim on 2023/03/01.
//

import Foundation
import RxCocoa

class RunningStartViewModel {
    
    let viewTitle: String
    
    var goalDistance: BehaviorRelay<Float> = BehaviorRelay<Float>(value: 5.00)
    var goalTimeMinute: BehaviorRelay<Int> = BehaviorRelay<Int>(value: 30)
    
    init(viewTitle: String) {
        self.viewTitle = viewTitle
    }
    
}
