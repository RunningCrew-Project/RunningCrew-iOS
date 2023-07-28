//
//  MyPageView.swift
//  RunningCrew
//
//  Created by 김기훈 on 2023/07/21.
//

import UIKit
import SnapKit

final class MyPageView: BaseView {
    
    lazy var profileImage: UIImageView = {
        let iamgeView = UIImageView()
        iamgeView.image = UIImage(systemName: "person.circle")
        
        return iamgeView
    }()
    
    lazy var needLogInTitle: UILabel = {
        let label = UILabel()
        label.text = "로그인하세요"
        label.font = UIFont(name: "NotoSansKR-Medium", size: 24)
        label.textColor = .darkModeBasicColor
        
        return label
    }()
    
    lazy var profileTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "NotoSansKR-Medium", size: 24)
        label.textColor = .darkModeBasicColor
        label.isHidden = true
        
        return label
    }()
    
    lazy var profileChangeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "pencil.circle"), for: .normal)
        button.isHidden = true
        
        return button
    }()
    
    lazy var customTabBar: CustomTabBar = {
        let view = CustomTabBar(items: items)
        view.backgroundColor = .red
        return view
    }()
    
    lazy var pageView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    lazy var needLogInLabel: UILabel = {
        let label = UILabel()
        label.text = "로그인하면 이용할 수 있습니다"
        
        return label
    }()
    
    private var items: [MenuItem]
    
    init(items: [MenuItem]) {
        self.items = items
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func addViews() {
        self.addSubview(profileImage)
        self.addSubview(needLogInTitle)
        self.addSubview(profileTitle)
        self.addSubview(profileChangeButton)
        self.addSubview(customTabBar)
        self.addSubview(pageView)
        pageView.addSubview(needLogInLabel)
    }
    
    override func setConstraint() {
        profileImage.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide.snp.bottom).multipliedBy(196.0/1288.0)
            $0.width.equalToSuperview().multipliedBy(166.0/750.0)
            $0.height.equalTo(profileImage.snp.width)
            $0.leading.equalTo(self.safeAreaLayoutGuide.snp.trailing).multipliedBy(48.0/750.0)
        }
        
        needLogInTitle.snp.makeConstraints {
            $0.centerY.equalTo(profileImage.snp.centerY)
            $0.leading.equalTo(self.safeAreaLayoutGuide.snp.trailing).multipliedBy(298.0/750.0)
        }
        
        profileTitle.snp.makeConstraints {
            $0.centerY.equalTo(profileImage.snp.centerY)
            $0.leading.equalTo(self.safeAreaLayoutGuide.snp.trailing).multipliedBy(298.0/750.0)
        }
        
        profileChangeButton.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(40.0/750.0)
            $0.height.equalTo(profileChangeButton.snp.width)
            $0.leading.equalTo(profileTitle.snp.trailing).offset(14)
        }
        
        customTabBar.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide.snp.bottom).multipliedBy(402.0/1288.0)
            $0.trailing.leading.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(120.0/1624.0)
        }
        
        pageView.snp.makeConstraints {
            $0.top.equalTo(customTabBar.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom)
        }
        
        needLogInLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
}
