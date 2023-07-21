//
//  ProfileStackview.swift
//  RunningCrew
//
//  Created by Dongwan Ryoo on 2023/04/05.
//

import UIKit

class ProfileStackview: UIStackView {
    
    lazy var container:UIStackView = {
        let stackview = UIStackView()
        stackview.backgroundColor = .white
        stackview.autoresizingMask = [.flexibleTopMargin, .flexibleHeight]
        
        return stackview
    }()
    
    lazy var profileImage:UIImageView = {
        let iamgeView = UIImageView()
        iamgeView.image = UIImage(systemName: "person.circle")
        
        return iamgeView
    }()
    
    lazy var profileStackview:UIStackView = {
        let stackview = UIStackView()
        stackview.backgroundColor = .white
    
        return stackview
    }()
    
    lazy var profileTitle:UILabel = {
        let label = UILabel()
        label.text = "닉네임"
        label.font = UIFont(name: "NotoSansKR-Medium", size: 24)
        
        return label
    }()
    
    lazy var profileChagneButton:UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "pencil.circle"), for: .normal)
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setAddView()
        setView()
        setConstraint()
    }
    
    func setView() {
        self.backgroundColor = .white
        setprofileStackview()
    }
    
    func setAddView(){
        self.addSubview(container)
        container.addArrangedSubview(profileImage)
        container.addArrangedSubview(profileStackview)
        profileStackview.addArrangedSubview(profileTitle)
        profileStackview.addArrangedSubview(profileChagneButton)
        
    }
    
    func setConstraint() {

    }
    
    
    func setprofileStackview() {
        profileStackview.axis = .horizontal
        profileStackview.spacing  = 10

        
    }
    
    func containerConstraint() {
        container.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
        
    }
    
    
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
