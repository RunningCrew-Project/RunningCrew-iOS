//
//  SettingView.swift
//  RunningCrew
//
//  Created by 김기훈 on 2023/08/10.
//

import UIKit
import SnapKit

final class SettingView: BaseView {
    
    lazy var topStackView = TopSettingView()
    
    lazy var midStackView = MidSettingView()
    
    lazy var bottomStackView = BottomSettingView()
    
    override func addViews() {
        self.addSubview(topStackView)
        self.addSubview(midStackView)
        self.addSubview(bottomStackView)
    }
    
    override func setConstraint() {
        topStackView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        midStackView.snp.makeConstraints {
            $0.top.equalTo(topStackView.snp.bottom).offset(50)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        bottomStackView.snp.makeConstraints {
            $0.top.equalTo(midStackView.snp.bottom).offset(50)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
    }
}
