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
        label.font = UIFont(name: "NotoSansKR-Bold", size: 40)
        
        return label
    }()
    
    lazy var kakaoLogInButton: UIButton = {
        let button = UIButton()
        button.setTitle("카카오 로그인", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor(named: "kakaoDefault")
        
        return button
    }()
    
    lazy var kakaoLogo: UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "message.fill"))
        image.tintColor = .black
        return image
    }()
    
    lazy var googleLogInButton: UIButton = {
        let button = UIButton()
        button.setTitle("Google로 로그인", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor(named: "GoogleLogInButton")

        return button
    }()
    
    lazy var googleLogo: UIImageView = {
        let image = UIImageView(image: UIImage(named: "googleLogo"))
        return image
    }()
    
    lazy var appleLogInButton: UIButton = {
        let button = UIButton()
        button.setTitle("Apple로 로그인", for: .normal)
        button.setTitleColor(.systemBackground, for: .normal)
        button.backgroundColor  = .darkModeBasicColor
        
        return button
    }()
    
    lazy var appleLogo: UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "apple.logo"))
        image.tintColor = .systemBackground
        return image
    }()
    
    override func addViews() {
        addSubview(logInTitle)
        addSubview(kakaoLogInButton)
        addSubview(kakaoLogo)
        addSubview(googleLogInButton)
        addSubview(googleLogo)
        addSubview(appleLogInButton)
        addSubview(appleLogo)
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
        
        kakaoLogo.snp.makeConstraints {
            $0.centerY.equalTo(kakaoLogInButton)
            $0.leading.equalTo(kakaoLogInButton).offset(10)
        }
        
        googleLogInButton.snp.makeConstraints {
            $0.top.equalTo(kakaoLogInButton.snp.bottom).offset(30)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(654.0/750.0)
            $0.height.equalToSuperview().multipliedBy(96.0/1624.0)
        }
        
        googleLogo.snp.makeConstraints {
            $0.centerY.equalTo(googleLogInButton)
            $0.leading.equalTo(googleLogInButton).offset(10)
            $0.width.height.equalTo(googleLogInButton.snp.height).multipliedBy(0.5)
        }
        
        appleLogInButton.snp.makeConstraints {
            $0.top.equalTo(googleLogInButton.snp.bottom).offset(30)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(654.0/750.0)
            $0.height.equalToSuperview().multipliedBy(96.0/1624.0)
        }
        
        appleLogo.snp.makeConstraints {
            $0.centerY.equalTo(appleLogInButton)
            $0.leading.equalTo(appleLogInButton).offset(10)
        }
    }
}
