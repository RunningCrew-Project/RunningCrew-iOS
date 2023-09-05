//
//  RecordRunningView.swift
//  RunningCrew
//
//  Created by 김기훈 on 2023/07/15.
//

import UIKit
import SnapKit

final class RecordRunningView: BaseView {
    
    lazy var advertisementContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray4
        
        return view
    }()
    
    lazy var locationLabel: UIButton = {
        let button = LocationLabel()
        button.contentHorizontalAlignment = .left
        button.isUserInteractionEnabled = false
        
        return button
    }()
    
    lazy var locationButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "LocationButton"), for: .normal)
        
        return button
        
    }()
    
    lazy var discussionLabel: UILabel = {
        let label = UILabel()
        label.text = "러닝 기록하기"
        label.textColor = .darkModeBasicColor
        label.font = UIFont(name: "NotoSansKR-Bold", size: 24)
        
        return label
    }()
    
    lazy var individualRunningButton: UIButton = {
        let button = RunningButton()
        button.backgroundColor = .tabBarSelect
        button.setTitle("개인 러닝", for: .normal)
        button.discussionLabel.text = "혼자서도 잘 달릴수 있어요"
        
        return button
    }()
    
    lazy var crewRunningButton: UIButton = {
        let button = RunningButton()
        button.backgroundColor = .darkGreen
        button.setTitle("크루 러닝", for: .normal)
        button.discussionLabel.text = "크루원들과 함께 힘찬 러닝"
        return button
    }()

    override func addViews() {
        self.addSubview(advertisementContainer)
        self.addSubview(locationLabel)
        self.addSubview(locationButton)
        self.addSubview(discussionLabel)
        self.addSubview(individualRunningButton)
        self.addSubview(crewRunningButton)
    }
    
    override func setConstraint() {
        advertisementContainer.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(self.safeAreaLayoutGuide)
            $0.height.equalToSuperview().multipliedBy(CGFloat(Double(120) / Double(1624)))
        }

        locationLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().multipliedBy(CGFloat(Double(288) / Double(1624)))
            $0.leading.equalToSuperview().offset(10)
            $0.height.equalToSuperview().multipliedBy(CGFloat(Double(68) / Double(1624)))
        }
        
        locationButton.snp.makeConstraints {
            $0.centerY.equalTo(locationLabel)
            $0.height.width.equalTo(locationLabel.snp.height).multipliedBy(0.6)
            $0.leading.equalTo(locationLabel.snp.trailing).offset(10)
        }

        discussionLabel.snp.makeConstraints {
            $0.top.equalTo(locationLabel.snp.bottom)
            $0.centerX.equalToSuperview().multipliedBy(CGFloat(Double(186) / Double(375)))
            $0.height.equalToSuperview().multipliedBy(CGFloat(Double(70) / Double(1624)))
        }
        
        individualRunningButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().multipliedBy(CGFloat(Double(880) / Double(1624)))
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(CGFloat(Double(654) / Double(750)))
            $0.height.equalToSuperview().multipliedBy(CGFloat(Double(468) / Double(1624)))
        }
        
        crewRunningButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().multipliedBy(CGFloat(Double(1396) / Double(1624)))
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(CGFloat(Double(654) / Double(750)))
            $0.height.equalToSuperview().multipliedBy(CGFloat(Double(468) / Double(1624)))
        }
    }
}
