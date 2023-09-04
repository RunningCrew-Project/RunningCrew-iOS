//
//  AlarmView.swift
//  RunningCrew
//
//  Created by 김기훈 on 2023/08/09.
//

import UIKit
import SnapKit

final class AlarmView: BaseView {
    
    lazy var customTabBar: CustomTabBar = {
        let view = CustomTabBar(items: items)
        view.backgroundColor = .red
        return view
    }()
    
    lazy var pageView: UIView = {
        let view = UIView()

        return view
    }()
    
    lazy var needLogInView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    lazy var needLogInLabel: UILabel = {
        let label = UILabel()
        label.text = "로그인하면 이용할 수 있습니다"
        
        return label
    }()
        
    private let items: [MenuItem]
    
    init(items: [MenuItem]) {
        self.items = items
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func addViews() {
        self.addSubview(customTabBar)
        self.addSubview(pageView)
        pageView.addSubview(needLogInView)
        needLogInView.addSubview(needLogInLabel)
    }
    
    override func setConstraint() {
        customTabBar.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(120.0/1624.0)
        }
        
        pageView.snp.makeConstraints {
            $0.top.equalTo(customTabBar.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        needLogInView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        needLogInLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
}
