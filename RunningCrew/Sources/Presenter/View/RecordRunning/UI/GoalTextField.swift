//
//  DestinationTextField.swift
//  RunningCrew
//
//  Created by JunHwan Kim on 2023/02/25.
//

import UIKit
import RxCocoa
import RxRelay
import RxSwift

class GoalTextField: UITextField {
    
    var goalType: BehaviorRelay<GoalType>
    var disposeBag = DisposeBag()
    
    init(goalType: BehaviorRelay<GoalType>) {
        self.goalType = goalType
        super.init(frame: .zero)
        backgroundColor = .clear
        borderStyle = .none
        textColor = .clear
        setKeyboard()
    }
    
    func setKeyboard() {
        goalType.bind { type in
            switch type {
            case .distance:
                self.keyboardType = .decimalPad
            case .time:
                self.keyboardType = .numberPad
            }
        }
        .disposed(by: disposeBag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func caretRect(for position: UITextPosition) -> CGRect {
        return .null
    }
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        false
    }
    
    override func selectionRects(for range: UITextRange) -> [UITextSelectionRect] {
        []
    }

}


