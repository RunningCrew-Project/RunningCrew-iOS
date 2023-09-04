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
        label.font = UIFont.systemFont(ofSize: 20)
        
        return label
    }()
    
    lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "이름을 입력해주세요"
        textField.backgroundColor = .lightGray
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftViewMode = .always
        
        return textField
    }()
    
    private lazy var nickNameTitle: UILabel = {
        let label: UILabel = UILabel()
        label.text = "닉네임"
        label.font = UIFont.systemFont(ofSize: 20)
        
        return label
    }()
    
    lazy var nickNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "최소 2자, 최대 8자"
        textField.backgroundColor = .lightGray
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftViewMode = .always
        
        return textField
    }()
    
    lazy var nickNameValidateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        
        return label
    }()
    
    private lazy var areaTitle: UILabel = {
        let label: UILabel = UILabel()
        label.text = "활동지역"
        label.font = UIFont.systemFont(ofSize: 20)
        
        return label
    }()
    
    lazy var toolBar: UIToolbar = {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let confirmButton = UIBarButtonItem(title: "확인", style: .done, target: self, action: nil)
        toolBar.setItems([spaceButton, confirmButton], animated: true)
        
        return toolBar
    }()
    
    lazy var siTextField: UITextField = {
        let textField: UITextField = UITextField()
        textField.text = "시"
        textField.tintColor = .systemBackground
        textField.inputView = siPickerView
        
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        button.tintColor = .darkModeBasicColor
        textField.rightView = button
        textField.rightViewMode = .always
        textField.inputAccessoryView = toolBar
        
        return textField
    }()
    
    lazy var siPickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.tintColor = .clear
        
        return pickerView
    }()
    
    lazy var guTextField: UITextField = {
        let textField: UITextField = UITextField()
        textField.text = "구"
        textField.tintColor = .systemBackground
        textField.inputView = guPickerView
        
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        button.tintColor = .darkModeBasicColor
        textField.rightView = button
        textField.rightViewMode = .always
        textField.inputAccessoryView = toolBar
        
        return textField
    }()
    
    lazy var guPickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.tintColor = .clear
        
        return pickerView
    }()
    
    lazy var dongTextField: UITextField = {
        let textField: UITextField = UITextField()
        textField.text = "동"
        textField.tintColor = .systemBackground
        textField.inputView = dongPickerView
        
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        button.tintColor = .darkModeBasicColor
        textField.rightView = button
        textField.rightViewMode = .always
        textField.inputAccessoryView = toolBar
        
        return textField
    }()
    
    lazy var dongPickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.tintColor = .clear
        
        return pickerView
    }()
    
    private lazy var genderTitle: UILabel = {
        let label: UILabel = UILabel()
        label.text = "성별"
        label.font = UIFont.systemFont(ofSize: 20)
        
        return label
    }()
    
    lazy var genderSegmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["남자", "여자"])
        segmentedControl.selectedSegmentIndex = 0
        return segmentedControl
    }()
    
    private lazy var birthTitle: UILabel = {
        let label: UILabel = UILabel()
        label.text = "생년월일"
        label.font = UIFont.systemFont(ofSize: 20)
        
        return label
    }()
    
    lazy var yearTitle: UITextField = {
        let textField: UITextField = UITextField()
        textField.text = "년"
        textField.tintColor = .systemBackground
        textField.inputView = birthPickerView
        
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        button.tintColor = .darkModeBasicColor
        textField.rightView = button
        textField.rightViewMode = .always
        textField.inputAccessoryView = toolBar
        
        return textField
    }()
    
    lazy var monthTitle: UITextField = {
        let textField: UITextField = UITextField()
        textField.text = "월"
        textField.tintColor = .systemBackground
        textField.inputView = birthPickerView
        
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        button.tintColor = .darkModeBasicColor
        textField.rightView = button
        textField.rightViewMode = .always
        textField.inputAccessoryView = toolBar
        
        return textField
    }()
    
    lazy var dayTitle: UITextField = {
        let textField: UITextField = UITextField()
        textField.text = "일"
        textField.tintColor = .systemBackground
        textField.inputView = birthPickerView
        
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        button.tintColor = .darkModeBasicColor
        textField.rightView = button
        textField.rightViewMode = .always
        textField.inputAccessoryView = toolBar
        
        return textField
    }()
    
    lazy var birthPickerView: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.locale = Locale(identifier: "ko-KR")
        datePicker.maximumDate = Date()
        
        return datePicker
    }()
    
    private lazy var heightTitle: UILabel = {
        let label: UILabel = UILabel()
        label.text = "키"
        label.font = UIFont.systemFont(ofSize: 20)
        
        return label
    }()
    
    lazy var heightTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "키를 입력해주세요"
        textField.backgroundColor = .lightGray
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftViewMode = .always
        
        let label = UILabel()
        label.text = "cm  "
        textField.rightView = label
        textField.rightViewMode = .always
        
        return textField
    }()
    
    private lazy var weightTitle: UILabel = {
        let label: UILabel = UILabel()
        label.text = "몸무게"
        label.font = UIFont.systemFont(ofSize: 20)
        
        return label
    }()
    
    lazy var weightTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "몸무게를 입력해주세요"
        textField.backgroundColor = .lightGray
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftViewMode = .always
        
        let label = UILabel()
        label.text = "kg  "
        textField.rightView = label
        textField.rightViewMode = .always
        
        return textField
    }()
    
    lazy var signUpButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .lightGreen
        button.setTitleColor(.white, for: .normal)
        button.setTitle("회원가입", for: .normal)
        
        return button
    }()
    
    init() {
        super.init(frame: .zero)
        siTextField.delegate = self
        guTextField.delegate = self
        dongTextField.delegate = self
        yearTitle.delegate = self
        monthTitle.delegate = self
        dayTitle.delegate = self
        heightTextField.delegate = self
        weightTextField.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func addViews() {
        self.addSubview(scrollView)
        scrollView.addSubview(containerView)
        
        containerView.addSubview(nameTitle)
        containerView.addSubview(nameTextField)
        containerView.addSubview(nickNameTitle)
        containerView.addSubview(nickNameTextField)
        containerView.addSubview(nickNameValidateLabel)
        
        containerView.addSubview(areaTitle)
        containerView.addSubview(siTextField)
        containerView.addSubview(guTextField)
        containerView.addSubview(dongTextField)
        
        containerView.addSubview(genderTitle)
        containerView.addSubview(genderSegmentedControl)
        containerView.addSubview(birthTitle)
        containerView.addSubview(yearTitle)
        containerView.addSubview(monthTitle)
        containerView.addSubview(dayTitle)
        
        containerView.addSubview(heightTitle)
        containerView.addSubview(heightTextField)
        containerView.addSubview(weightTitle)
        containerView.addSubview(weightTextField)
        containerView.addSubview(signUpButton)
    }
    
    override func setConstraint() {
        scrollView.snp.makeConstraints {
            $0.edges.equalTo(safeAreaLayoutGuide)
        }
        
        containerView.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(10)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.width.equalToSuperview().inset(20)
        }
        
        nameTitle.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(safeAreaLayoutGuide).multipliedBy(0.03)
        }
        
        nameTextField.snp.makeConstraints {
            $0.top.equalTo(nameTitle.snp.bottom).offset(14)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(safeAreaLayoutGuide).multipliedBy(0.07)
        }
        
        nickNameTitle.snp.makeConstraints {
            $0.top.equalTo(nameTextField.snp.bottom).offset(26)
            $0.leading.equalToSuperview()
            $0.height.equalTo(safeAreaLayoutGuide).multipliedBy(0.03)
        }
        
        nickNameTextField.snp.makeConstraints {
            $0.top.equalTo(nickNameTitle.snp.bottom).offset(14)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(safeAreaLayoutGuide).multipliedBy(0.07)
        }
        
        nickNameValidateLabel.snp.makeConstraints {
            $0.top.equalTo(nickNameTextField.snp.bottom).offset(2)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(safeAreaLayoutGuide).multipliedBy(0.02)
        }
        
        areaTitle.snp.makeConstraints {
            $0.top.equalTo(nickNameValidateLabel.snp.bottom).offset(26)
            $0.leading.equalToSuperview()
            $0.height.equalTo(safeAreaLayoutGuide).multipliedBy(0.03)
        }
        
        siTextField.snp.makeConstraints {
            $0.top.equalTo(areaTitle.snp.bottom).offset(14)
            $0.leading.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.35)
            $0.height.equalTo(safeAreaLayoutGuide).multipliedBy(0.03)
        }

        guTextField.snp.makeConstraints {
            $0.top.equalTo(areaTitle.snp.bottom).offset(14)
            $0.centerX.equalTo(dongTextField).multipliedBy(0.62)
            $0.width.equalToSuperview().multipliedBy(0.25)
            $0.height.equalTo(safeAreaLayoutGuide).multipliedBy(0.03)
        }
        
        dongTextField.snp.makeConstraints {
            $0.top.equalTo(areaTitle.snp.bottom).offset(14)
            $0.trailing.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.25)
            $0.height.equalTo(safeAreaLayoutGuide).multipliedBy(0.03)
        }
        
        genderTitle.snp.makeConstraints {
            $0.top.equalTo(siTextField.snp.bottom).offset(26)
            $0.leading.equalToSuperview()
            $0.height.equalTo(safeAreaLayoutGuide).multipliedBy(0.03)
        }
        
        genderSegmentedControl.snp.makeConstraints {
            $0.top.equalTo(genderTitle.snp.bottom).offset(14)
            $0.leading.equalToSuperview()
            $0.height.equalTo(safeAreaLayoutGuide).multipliedBy(0.05)
        }
        
        birthTitle.snp.makeConstraints {
            $0.top.equalTo(genderSegmentedControl.snp.bottom).offset(26)
            $0.leading.equalToSuperview()
            $0.height.equalTo(safeAreaLayoutGuide).multipliedBy(0.03)
        }
        
        yearTitle.snp.makeConstraints {
            $0.top.equalTo(birthTitle.snp.bottom).offset(14)
            $0.leading.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.35)
            $0.height.equalTo(safeAreaLayoutGuide).multipliedBy(0.03)
        }
        
        monthTitle.snp.makeConstraints {
            $0.top.equalTo(birthTitle.snp.bottom).offset(14)
            $0.centerX.equalTo(dongTextField).multipliedBy(0.62)
            $0.width.equalToSuperview().multipliedBy(0.25)
            $0.height.equalTo(safeAreaLayoutGuide).multipliedBy(0.03)
        }
        
        dayTitle.snp.makeConstraints {
            $0.top.equalTo(birthTitle.snp.bottom).offset(14)
            $0.trailing.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.25)
            $0.height.equalTo(safeAreaLayoutGuide).multipliedBy(0.03)
        }
        
        heightTitle.snp.makeConstraints {
            $0.top.equalTo(yearTitle.snp.bottom).offset(26)
            $0.leading.equalToSuperview()
            $0.height.equalTo(safeAreaLayoutGuide).multipliedBy(0.03)
        }
        
        heightTextField.snp.makeConstraints {
            $0.top.equalTo(heightTitle.snp.bottom).offset(14)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(safeAreaLayoutGuide).multipliedBy(0.07)
        }
        
        weightTitle.snp.makeConstraints {
            $0.top.equalTo(heightTextField.snp.bottom).offset(26)
            $0.leading.equalToSuperview()
            $0.height.equalTo(safeAreaLayoutGuide).multipliedBy(0.03)
        }
        
        weightTextField.snp.makeConstraints {
            $0.top.equalTo(weightTitle.snp.bottom).offset(14)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(safeAreaLayoutGuide).multipliedBy(0.07)
        }
        
        signUpButton.snp.makeConstraints {
            $0.top.equalTo(weightTextField.snp.bottom).offset(26)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(safeAreaLayoutGuide).multipliedBy(0.1)
            $0.bottom.equalTo(containerView).inset(10)
        }
    }
}

extension SignUpView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.endEditing(true)
        return true
    }
}
