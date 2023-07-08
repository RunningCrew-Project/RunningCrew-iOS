//
//  button.swift
//  RunningCrew
//
//  Created by Dongwan Ryoo on 2023/07/06.
//

import UIKit

class GenderButton: UIView {
    //MARK: - UI ProPerties
    
    lazy var genderPick:UIButton = {
        let button = UIButton()
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 2
        button.layer.cornerRadius = 10
        return button
    }()
    
    lazy var gender:UILabel = {
        let label = UILabel()
        label.text = "남성"
        label.font = UIFont(name: "NotoSansKR-Medium", size: 14)
        label.textColor = .black
        
        return label
    }()
    
    
    //MARK: - Define Method

    override init(frame: CGRect) {
        super.init(frame: frame)
        SetView()
        Constraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Properties
    
    
    //MARK: - Set Ui
    func SetView() {
        [gender, genderPick].forEach { view in
            self.addSubview(view)
        }
    }
    
    func Constraint() {
        self.snp.makeConstraints { make in
            make.width.equalTo(36)
            make.height.equalTo(20)
        }
        
        genderPick.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.leading.equalTo(safeAreaLayoutGuide)
        }
        
        gender.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.leading.equalTo(genderPick.snp.trailing).offset(2)
        }
        
    }

}
