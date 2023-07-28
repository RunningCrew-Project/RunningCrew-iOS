//
//  SignUpView.swift
//  RunningCrew
//
//  Created by 김기훈 on 2023/07/28.
//

import UIKit
import SnapKit

final class SignUpView: BaseView {
    
    lazy var nameTitle: UILabel = {
        let label: UILabel = UILabel()
        label.text = "이름"
        
        return label
    }()
    
    lazy var nickNameTitle: UILabel = {
        let label: UILabel = UILabel()
        label.text = "닉네임"
        
        return label
    }()
    
    lazy var areaTitle: UILabel = {
        let label: UILabel = UILabel()
        label.text = "활동지역"
        
        return label
    }()
    
    lazy var genderTitle: UILabel = {
        let label: UILabel = UILabel()
        label.text = "성별"
        
        return label
    }()
    
    lazy var birthTitle: UILabel = {
        let label: UILabel = UILabel()
        label.text = "생년월일"
        
        return label
    }()
    
    lazy var heightTitle: UILabel = {
        let label: UILabel = UILabel()
        label.text = "키"
        
        return label
    }()
    
    lazy var weightTitle: UILabel = {
        let label: UILabel = UILabel()
        label.text = "몸무게"
        
        return label
    }()
    
    override func addViews() {
        self.addSubview(nameTitle)
        
        self.addSubview(nickNameTitle)
        
        self.addSubview(areaTitle)
        
        self.addSubview(genderTitle)
        
        self.addSubview(birthTitle)
        
        self.addSubview(heightTitle)
        
        self.addSubview(weightTitle)
    }
    
    override func setConstraint() { }
}
