//
//  GoalSettingView.swift
//  RunningCrew
//
//  Created by 김기훈 on 2023/07/15.
//

import UIKit
import SnapKit

final class GoalSettingView: BaseView {
    
    lazy var goalLabelBindingTextField: GoalTextField = {
        let textField = GoalTextField()
        textField.becomeFirstResponder()
        textField.keyboardType = .numberPad
        
        return textField
    }()
    
    lazy var goalLabel: GoalSettingStackView = {
        let goalLabel = GoalSettingStackView()
        
        return goalLabel
    }()
    
    override func addViews() {
        self.addSubview(goalLabelBindingTextField)
        self.addSubview(goalLabel)
    }
    
    override func setConstraint() {
        goalLabelBindingTextField.snp.makeConstraints {
            $0.bottom.equalTo(goalLabel.snp.top)
            $0.centerX.equalToSuperview()
        }
        
        goalLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
}
