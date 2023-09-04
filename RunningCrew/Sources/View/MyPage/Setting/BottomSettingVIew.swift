//
//  BottomSettingVIew.swift
//  RunningCrew
//
//  Created by 김기훈 on 2023/08/10.
//

import UIKit
import SnapKit

final class BottomSettingView: UIStackView {
    
    lazy var logOutStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        
        return stackView
    }()
    
    lazy var logOutLabel: UILabel = {
        let label = UILabel()
        label.text = "로그아웃"
        
        return label
    }()
    
    lazy var logOutButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "greaterthan"), for: .normal)
        
        return button
    }()
    
    lazy var termsOfServiceStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        
        return stackView
    }()
    
    lazy var termsOfServiceLabel: UILabel = {
        let label = UILabel()
        label.text = "서비스 약관"
        
        return label
    }()
    
    lazy var termsOfServiceButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "greaterthan"), for: .normal)
        
        return button
    }()
    
    lazy var withdrawalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        
        return stackView
    }()
    
    lazy var withdrawalLabel: UILabel = {
        let label = UILabel()
        label.text = "회원 탈퇴"
        
        return label
    }()
    
    lazy var withdrawalButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "greaterthan"), for: .normal)
        
        return button
    }()
    
    lazy var versionStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
        
        return stackView
    }()
    
    lazy var versionLabel: UILabel = {
        let label = UILabel()
        label.text = "버전"
        
        return label
    }()
    
    lazy var versionNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "1.0.0 최신 버전입니다."
        
        return label
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
        self.addArrangedSubview(logOutStackView)
        logOutStackView.addArrangedSubview(logOutLabel)
        logOutStackView.addArrangedSubview(logOutButton)
        
        self.addArrangedSubview(termsOfServiceStackView)
        termsOfServiceStackView.addArrangedSubview(termsOfServiceLabel)
        termsOfServiceStackView.addArrangedSubview(termsOfServiceButton)
        
        self.addArrangedSubview(withdrawalStackView)
        withdrawalStackView.addArrangedSubview(withdrawalLabel)
        withdrawalStackView.addArrangedSubview(withdrawalButton)
        
        self.addArrangedSubview(versionStackView)
        versionStackView.addArrangedSubview(versionLabel)
        versionStackView.addArrangedSubview(versionNumberLabel)
    }
    
    private func setConstraint() {
        logOutStackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
        }
        
        logOutLabel.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.9)
        }
        
        termsOfServiceStackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
        }

        termsOfServiceLabel.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.9)
        }

        withdrawalStackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
        }

        withdrawalLabel.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.9)
        }

        versionStackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
        }
    }
}
