//
//  uiview.swift
//  RunningCrew
//
//  Created by Dongwan Ryoo on 2023/07/06.
//

import UIKit
import SnapKit

class ProfileChnageView: UIView, UIScrollViewDelegate  {
    //MARK: - UI ProPerties
    
    lazy var scrollview:UIScrollView =  {
       let view = UIScrollView()
        view.contentSize = CGSize(width: self.frame.width, height: self.frame.height)

        return view
    }()
    
    //프로필 이미지
    lazy var profileImage:UIImageView = {
        let iamgeView = UIImageView()
        iamgeView.image = UIImage(systemName: "person.circle")
        
        return iamgeView
    }()
    
    //닉네임
    lazy var profileTitle:UILabel = {
        let label = UILabel()
        label.text = "닉네임"
        label.font = UIFont(name: "NotoSansKR-Medium", size: 24)
        label.textColor = .black
        
        return label
    }()
    
    //이름
    lazy var name:UILabel = {
        let label = UILabel()
        label.text = "이름"
        label.font = UIFont(name: "NotoSansKR-Medium", size: 14)
        label.textColor = .black
        
        return label
    }()
    
    //이름받는 텍스트 필드
    lazy var nameTextField:UITextField = {
        let TF = UITextField()
        TF.backgroundColor = .lightGreen
        return TF
    }()
    
    //닉네임
    lazy var nickname:UILabel = {
        let label = UILabel()
        label.text = "닉네임"
        label.font = UIFont(name: "NotoSansKR-Medium", size: 14)
        label.textColor = .black
        
        return label
    }()
    
    //닉네임받는 텍스트 필드
    lazy var nicknameTextField:UITextField = {
        let TF = UITextField()
        TF.backgroundColor = .lightGreen
        
        return TF
    }()
    
    //활동 지역
    lazy var activityArea:UILabel = {
        let label = UILabel()
        label.text = "활동 지역"
        label.font = UIFont(name: "NotoSansKR-Medium", size: 14)
        label.textColor = .black
        
        return label
    }()
    
    //시 선택 피커뷰
    let pickerView1: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.backgroundColor = .blue
        
        return pickerView
    }()
    
    //구 선택 피커뷰
    let pickerView2: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.backgroundColor = .blue
        
        return pickerView
    }()
    
    //동 선택 피커뷰
    let pickerView3: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.backgroundColor = .blue
        
        return pickerView
    }()
    
    //성별
    lazy var genderLabel:UILabel = {
        let label = UILabel()
        label.text = "활동 지역"
        label.font = UIFont(name: "NotoSansKR-Medium", size: 14)
        label.textColor = .black
        
        return label
    }()
    
    //남성
    lazy var manPick:GenderButton = {
        let view = GenderButton()
        view.gender.text = "남성"
        
        return view
    }()
    
    //여성
    lazy var womanPick:GenderButton = {
        let view = GenderButton()
        view.gender.text = "여성"
        
        return view
    }()
    
    //생년 월일
    lazy var birthDate:UILabel = {
        let label = UILabel()
        label.text = "생년 월일"
        label.font = UIFont(name: "NotoSansKR-Medium", size: 14)
        label.textColor = .black
        
        return label
    }()
    
    //일 선택 피커뷰
    let pickerView4: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.backgroundColor = .blue
        
        return pickerView
    }()
    
    //년 선택 피커뷰
    let pickerView5: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.backgroundColor = .blue
        
        return pickerView
    }()
    
    //월 선택 피커뷰
    let pickerView6: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.backgroundColor = .blue
        
        return pickerView
    }()
    
    //키
    lazy var heightLabel:UILabel = {
        let label = UILabel()
        label.text = "키"
        label.font = UIFont(name: "NotoSansKR-Medium", size: 14)
        label.textColor = .black
        
        return label
    }()
    
    //키 입력 받을 TF
    lazy var heightTextField:UITextField = {
        let TF = UITextField()
        TF.backgroundColor = .lightGreen
        
        return TF
    }()
    
    //몸무게
    lazy var weightLabel:UILabel = {
        let label = UILabel()
        label.text = "몸무게"
        label.font = UIFont(name: "NotoSansKR-Medium", size: 14)
        label.textColor = .black
        
        return label
    }()
    
    //몸무게 입력 받을 TF
    lazy var weightTextField:UITextField = {
        let TF = UITextField()
        TF.backgroundColor = .lightGreen
        
        return TF
    }()
    
    //키와 몸무게 정보를 받을 안내 텍스트
    lazy var calorieLabel:UILabel = {
        let label = UILabel()
        label.text = "키와 몸무게를 입력하면 러닝시 칼로리를 측정할 수 있습니다"
        label.font = UIFont(name: "NotoSansKR-Medium", size: 12)
        label.textColor = .lightGray
        
        return label
    }()
    
    lazy var saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("변경사항 저장", for: .normal)
        button.backgroundColor = .darkGreen
        button.titleLabel?.font = UIFont(name: "NotoSansKR-Medium", size: 16)
        button.titleLabel?.textAlignment = .center
        
        return button
    }()
    
    //MARK: - Define Method
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
        constraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 스크롤 뷰가 스크롤되는 동안 호출되는 메서드
    }
    
    
    //MARK: - Properties
    
    
    //MARK: - Set Ui
    
    func setView() {
        self.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 2000)
        self.addSubview(scrollview)
        [profileImage, profileTitle, name, nameTextField, nickname, nicknameTextField, activityArea, pickerView1, pickerView2, pickerView3, genderLabel, manPick, womanPick, birthDate, pickerView4, pickerView5, pickerView6, heightLabel, heightTextField, weightLabel, weightTextField, calorieLabel, saveButton].forEach { view in
            scrollview.addSubview(view)
        }
        scrollview.delegate = self
        
        let contentHeight = saveButton.frame.maxY + 20
        scrollview.contentSize = CGSize(width: frame.width, height: contentHeight)
    }


    func constraint() {
        let leading = 24
        let top = 7
        
        scrollview.snp.makeConstraints { make in
            make.leading.equalTo(self.snp.leading)
            make.top.equalTo(self.snp.top)
            make.trailing.equalTo(self.snp.trailing)
            make.bottom.equalTo(self.snp.bottom)

        }
        
        profileImage.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(38)
            make.centerX.equalTo(safeAreaLayoutGuide)
            make.size.equalTo(83)
        }
        
        profileTitle.snp.makeConstraints { make in
            make.top.equalTo(profileImage.snp.bottom).offset(20)
            make.centerX.equalTo(safeAreaLayoutGuide)
        }
        
        name.snp.makeConstraints { make in
            make.top.equalTo(profileTitle.snp.bottom).offset(29)
            make.leading.equalTo(safeAreaLayoutGuide).offset(leading)
        }
        
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(name.snp.bottom).offset(top)
            make.leading.equalTo(safeAreaLayoutGuide).offset(leading)
            make.width.equalTo(327)
            make.height.equalTo(52)
        }
        
        nickname.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).offset(13)
            make.leading.equalTo(safeAreaLayoutGuide).offset(leading)
        }
        
        nicknameTextField.snp.makeConstraints { make in
            make.top.equalTo(nickname.snp.bottom).offset(top)
            make.leading.equalTo(safeAreaLayoutGuide).offset(leading)
            make.width.equalTo(327)
            make.height.equalTo(52)
        }
        
        activityArea.snp.makeConstraints { make in
            make.top.equalTo(nicknameTextField.snp.bottom).offset(13)
            make.leading.equalTo(safeAreaLayoutGuide).offset(leading)
        }
        
        pickerView1.snp.makeConstraints { make in
            make.top.equalTo(activityArea.snp.bottom).offset(11)
            make.leading.equalTo(safeAreaLayoutGuide).offset(leading)
            make.width.equalTo(110)
            make.height.equalTo(20)
        }
        
        pickerView2.snp.makeConstraints { make in
            make.top.equalTo(activityArea.snp.bottom).offset(11)
            make.leading.equalTo(pickerView1.snp.trailing).offset(leading)
            make.width.equalTo(70)
            make.height.equalTo(20)
        }
        
        pickerView3.snp.makeConstraints { make in
            make.top.equalTo(activityArea.snp.bottom).offset(11)
            make.leading.equalTo(pickerView2.snp.trailing).offset(leading)
            make.width.equalTo(70)
            make.height.equalTo(20)
        }
        
        genderLabel.snp.makeConstraints { make in
            make.top.equalTo(pickerView1.snp.bottom).offset(23)
            make.leading.equalTo(safeAreaLayoutGuide).offset(leading)
        }
        
        manPick.snp.makeConstraints { make in
            make.top.equalTo(genderLabel.snp.bottom).offset(top)
            make.leading.equalTo(safeAreaLayoutGuide).offset(leading)
        }
        womanPick.snp.makeConstraints { make in
            make.top.equalTo(genderLabel.snp.bottom).offset(top)
            make.leading.equalTo(manPick.snp.trailing).offset(55)
        }
        
        birthDate.snp.makeConstraints { make in
            make.top.equalTo(manPick.snp.bottom).offset(13)
            make.leading.equalTo(safeAreaLayoutGuide).offset(leading)
        }
        
        pickerView4.snp.makeConstraints { make in
            make.top.equalTo(birthDate.snp.bottom).offset(11)
            make.leading.equalTo(safeAreaLayoutGuide).offset(leading)
            make.width.equalTo(110)
            make.height.equalTo(20)
        }
        
        pickerView5.snp.makeConstraints { make in
            make.top.equalTo(birthDate.snp.bottom).offset(11)
            make.leading.equalTo(pickerView4.snp.trailing).offset(leading)
            make.width.equalTo(70)
            make.height.equalTo(20)
        }
        
        pickerView6.snp.makeConstraints { make in
            make.top.equalTo(birthDate.snp.bottom).offset(11)
            make.leading.equalTo(pickerView5.snp.trailing).offset(leading)
            make.width.equalTo(70)
            make.height.equalTo(20)
        }
        
        heightLabel.snp.makeConstraints { make in
            make.top.equalTo(pickerView4.snp.bottom).offset(23)
            make.leading.equalTo(safeAreaLayoutGuide).offset(leading)
        }
        
        heightTextField.snp.makeConstraints { make in
            make.top.equalTo(heightLabel.snp.bottom).offset(top)
            make.leading.equalTo(safeAreaLayoutGuide).offset(leading)
            make.width.equalTo(327)
            make.height.equalTo(52)
        }
        
        weightLabel.snp.makeConstraints { make in
            make.top.equalTo(heightTextField.snp.bottom).offset(13)
            make.leading.equalTo(safeAreaLayoutGuide).offset(leading)
        }
        
        weightTextField.snp.makeConstraints { make in
            make.top.equalTo(weightLabel.snp.bottom).offset(top)
            make.leading.equalTo(safeAreaLayoutGuide).offset(leading)
            make.width.equalTo(327)
            make.height.equalTo(52)
        }
        
        calorieLabel.snp.makeConstraints { make in
            make.top.equalTo(weightTextField.snp.bottom).offset(top)
            make.leading.equalTo(safeAreaLayoutGuide).offset(leading)
        }
        
        saveButton.snp.makeConstraints { make in
            make.top.equalTo(weightTextField.snp.bottom).offset(32)
            make.centerX.equalTo(safeAreaLayoutGuide)
            make.width.equalTo(327)
            make.height.equalTo(52)
        }
        
    }
    
}





