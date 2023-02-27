//
//  DestinationTextField.swift
//  RunningCrew
//
//  Created by JunHwan Kim on 2023/02/25.
//

import UIKit
import RxCocoa

class GoalTextField: UITextField {
    
    enum FieldType {
        case distance
        case time
    }
    
    var type: FieldType?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.keyboardType = .decimalPad
        backgroundColor = .clear
        borderStyle = .none
        textColor = .clear
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


