//
//  BaseView.swift
//  RunningCrew
//
//  Created by 김기훈 on 2023/07/20.
//

import UIKit

class BaseView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemBackground
        addViews()
        setConstraint()
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addViews() { }
    func setConstraint() { }
    func setUpUI() { }
}
