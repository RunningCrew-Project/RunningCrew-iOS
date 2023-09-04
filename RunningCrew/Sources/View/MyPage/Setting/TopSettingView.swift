//
//  TopSettingView.swift
//  RunningCrew
//
//  Created by 김기훈 on 2023/08/23.
//

import UIKit
import SnapKit

final class TopSettingView: UIStackView {
    
    lazy var authTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "권한 설정"
        
        return label
    }()
    
    lazy var notificationStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        
        return stackView
    }()
    
    lazy var notificationLabelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 5
        
        return stackView
    }()
    
    lazy var notificationTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "알림 설정"
        
        return label
    }()
    
    lazy var notificationLabel: UILabel = {
        let label = UILabel()
        label.text = "OOO에서 제공하는 푸시알림에 동의합니다."
        
        return label
    }()
    
    lazy var notificationSwitch: UISwitch = {
        let uiSwitch = UISwitch()
        
        return uiSwitch
    }()
    
    lazy var locationStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        
        return stackView
    }()
    
    lazy var locationLabelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 5
        
        return stackView
    }()
    
    lazy var locationTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "위치 정보 수집 동의"
        
        return label
    }()
    
    lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.text = "사용자의 위치 기반 정보제공에 동의합니다."
        
        return label
    }()
    
    lazy var locationSwitch: UISwitch = {
        let uiSwitch = UISwitch()
        
        return uiSwitch
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.axis = .vertical
        self.spacing = 20
        self.distribution = .fillProportionally
        addViews()
        setConstraint()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addViews() {
        self.addArrangedSubview(authTitleLabel)
        
        self.addArrangedSubview(notificationStackView)
        notificationStackView.addArrangedSubview(notificationLabelStackView)
        notificationStackView.addArrangedSubview(notificationSwitch)
        notificationLabelStackView.addArrangedSubview(notificationTitleLabel)
        notificationLabelStackView.addArrangedSubview(notificationLabel)
        
        self.addArrangedSubview(locationStackView)
        locationStackView.addArrangedSubview(locationLabelStackView)
        locationStackView.addArrangedSubview(locationSwitch)
        locationLabelStackView.addArrangedSubview(locationTitleLabel)
        locationLabelStackView.addArrangedSubview(locationLabel)
    }
    
    private func setConstraint() {
        notificationStackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
        }
        
        locationStackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
        }
    }
}
