//
//  LogInView.swift
//  RunningCrew
//
//  Created by 김기훈 on 2023/07/21.
//

import UIKit
import SnapKit

final class LogInView: BaseView {
    
    lazy var logInTitle: UILabel = {
        let label: UILabel = UILabel()
        label.text = "로그인"
        
        return label
    }()
    
    lazy var kakaoLogInButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(named: "KakaoLogInButton")
        button.setTitle("카카오 로그인", for: .normal)
        button.setTitleColor(.black, for: .normal)
        
        return button
    }()
    
    lazy var googleLogInButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(named: "GoogleLogInButton")
        button.setTitle("Google 로그인", for: .normal)
        button.setTitleColor(.black, for: .normal)

        return button
    }()
    
    lazy var appleLogInButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(named: "AppleLogInButton")
        button.setTitle("Apple 로그인", for: .normal)
        button.setTitleColor(.systemBackground, for: .normal)
        
        return button
    }()
    
    override func addViews() {
        addSubview(logInTitle)
        addSubview(kakaoLogInButton)
        addSubview(googleLogInButton)
        addSubview(appleLogInButton)
    }
    
    override func setConstraint() {
        logInTitle.snp.makeConstraints {
            $0.top.equalToSuperview().offset(100)
            $0.centerX.equalToSuperview()
        }
        
        kakaoLogInButton.snp.makeConstraints {
            $0.top.equalTo(logInTitle.snp.bottom).offset(62)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(654.0/750.0)
            $0.height.equalToSuperview().multipliedBy(96.0/1624.0)
        }
        
        googleLogInButton.snp.makeConstraints {
            $0.top.equalTo(kakaoLogInButton.snp.bottom).offset(30)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(654.0/750.0)
            $0.height.equalToSuperview().multipliedBy(96.0/1624.0)
        }
        
        appleLogInButton.snp.makeConstraints {
            $0.top.equalTo(googleLogInButton.snp.bottom).offset(30)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(654.0/750.0)
            $0.height.equalToSuperview().multipliedBy(96.0/1624.0)
        }
    }
}
