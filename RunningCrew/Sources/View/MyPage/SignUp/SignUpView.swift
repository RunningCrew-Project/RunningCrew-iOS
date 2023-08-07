//
//  SignUpView.swift
//  RunningCrew
//
//  Created by 김기훈 on 2023/07/28.
//

import UIKit
import SnapKit

final class SignUpView: BaseView {
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    private lazy var nameTitle: UILabel = {
        let label: UILabel = UILabel()
        label.text = "이름"
        
        return label
    }()
    
    lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "이름을 입력해주세요"
        
        return textField
    }()
    
    private lazy var nickNameTitle: UILabel = {
        let label: UILabel = UILabel()
        label.text = "닉네임"
        
        return label
    }()
    
    lazy var nickNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "최소 2자, 최대 8자"
        
        return textField
    }()
    
    private lazy var areaTitle: UILabel = {
        let label: UILabel = UILabel()
        label.text = "활동지역"
        
        return label
    }()
    
    lazy var areaPickerView: UIPickerView = {
        let pickerView = UIPickerView()
        
        return pickerView
    }()
    
    private lazy var genderTitle: UILabel = {
        let label: UILabel = UILabel()
        label.text = "성별"
        
        return label
    }()
    
    lazy var genderSegmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["남자", "여자"])
        return segmentedControl
    }()
    
    private lazy var birthTitle: UILabel = {
        let label: UILabel = UILabel()
        label.text = "생년월일"
        
        return label
    }()
    
    lazy var birthPickerView: UIDatePicker = {
        let datePicker = UIDatePicker()
    
        return datePicker
    }()
    
    private lazy var heightTitle: UILabel = {
        let label: UILabel = UILabel()
        label.text = "키"
        
        return label
    }()
    
    lazy var heightTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "키를 입력해주세요"
        
        return textField
    }()
    
    private lazy var weightTitle: UILabel = {
        let label: UILabel = UILabel()
        label.text = "몸무게"
        
        return label
    }()
    
    lazy var weightTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "몸무게를 입력해주세요"
        
        return textField
    }()
    
    lazy var signUpButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .green
        button.setTitleColor(.darkModeBasicColor, for: .normal)
        button.setTitle("회원가입", for: .normal)
        
        return button
    }()
    
    private var selectedData: [String] = []
    private let si = ["서울", "성남", "고양"]
    private let gu = ["강남구"]
    private let dong = ["논현동"]
    
    init() {
        super.init(frame: .zero)
        areaPickerView.dataSource = self
        areaPickerView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func addViews() {
        addSubview(scrollView)
        scrollView.addSubview(containerView)
        
        containerView.addSubview(nameTitle)
        containerView.addSubview(nameTextField)
        containerView.addSubview(nickNameTitle)
        containerView.addSubview(nickNameTextField)
        containerView.addSubview(areaTitle)
        containerView.addSubview(areaPickerView)
        containerView.addSubview(genderTitle)
        containerView.addSubview(genderSegmentedControl)
        containerView.addSubview(birthTitle)
        containerView.addSubview(birthPickerView)
        containerView.addSubview(heightTitle)
        containerView.addSubview(heightTextField)
        containerView.addSubview(weightTitle)
        containerView.addSubview(weightTextField)
        containerView.addSubview(signUpButton)
    }
    
    override func setConstraint() {
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(containerView.snp.height)
        }
        
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(UIEdgeInsets(top: 10, left: 14, bottom: 10, right: 14))
            $0.width.equalToSuperview().inset(14)
            $0.bottom.equalTo(signUpButton.snp.bottom)
        }
        
        nameTitle.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
        }
        
        nameTextField.snp.makeConstraints {
            $0.top.equalTo(nameTitle.snp.bottom).offset(14)
            $0.leading.equalToSuperview()
        }
        
        nickNameTitle.snp.makeConstraints {
            $0.top.equalTo(nameTextField.snp.bottom).offset(26)
            $0.leading.equalToSuperview()
        }
        
        nickNameTextField.snp.makeConstraints {
            $0.top.equalTo(nickNameTitle.snp.bottom).offset(14)
            $0.leading.equalToSuperview()
        }
        
        areaTitle.snp.makeConstraints {
            $0.top.equalTo(nickNameTextField.snp.bottom).offset(26)
            $0.leading.equalToSuperview()
        }
        
        areaPickerView.snp.makeConstraints {
            $0.top.equalTo(areaTitle.snp.bottom).offset(14)
            $0.leading.equalToSuperview()
        }
        
        genderTitle.snp.makeConstraints {
            $0.top.equalTo(areaPickerView.snp.bottom).offset(26)
            $0.leading.equalToSuperview()
        }
        
        genderSegmentedControl.snp.makeConstraints {
            $0.top.equalTo(genderTitle.snp.bottom).offset(14)
            $0.leading.equalToSuperview()
        }
        
        birthTitle.snp.makeConstraints {
            $0.top.equalTo(genderSegmentedControl.snp.bottom).offset(26)
            $0.leading.equalToSuperview()
        }
        
        birthPickerView.snp.makeConstraints {
            $0.top.equalTo(birthTitle.snp.bottom).offset(14)
            $0.leading.width.equalToSuperview()
        }
        
        heightTitle.snp.makeConstraints {
            $0.top.equalTo(birthPickerView.snp.bottom).offset(26)
            $0.leading.equalToSuperview()
        }
        
        heightTextField.snp.makeConstraints {
            $0.top.equalTo(heightTitle.snp.bottom).offset(14)
            $0.leading.equalToSuperview()
        }
        
        weightTitle.snp.makeConstraints {
            $0.top.equalTo(heightTextField.snp.bottom).offset(26)
            $0.leading.equalToSuperview()
        }
        
        weightTextField.snp.makeConstraints {
            $0.top.equalTo(weightTitle.snp.bottom).offset(14)
            $0.leading.equalToSuperview()
        }
        
        signUpButton.snp.makeConstraints {
            $0.height.equalToSuperview().multipliedBy(0.1)
            $0.top.equalTo(weightTextField.snp.bottom).offset(26)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}

extension SignUpView: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return selectedData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return selectedData[row]
    }
}
