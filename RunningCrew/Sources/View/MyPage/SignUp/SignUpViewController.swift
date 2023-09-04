//
//  SignUpViewController.swift
//  RunningCrew
//
//  Created by 김기훈 on 2023/07/28.
//

import Foundation
import RxCocoa
import RxSwift

protocol SignUpViewControllerDelegate: AnyObject {
    func popSignUpView()
}

final class SignUpViewController: BaseViewController {
    
    weak var coordinator: SignUpViewControllerDelegate?
    
    private var signUpView: SignUpView!
    private var viewModel: SignUpViewModel
    
    private var selectedType: SelectedType?
    private var siData: [Area] = []
    private var guData: [Area] = []
    private var dongData: [Area] = []
    
    enum SelectedType {
        case si, gu, dong, date
    }
    
    init(viewModel: SignUpViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.signUpView = SignUpView()
        self.view = signUpView
            
        signUpView.siPickerView.delegate = self
        signUpView.siPickerView.dataSource = self
        signUpView.guPickerView.delegate = self
        signUpView.guPickerView.dataSource = self
        signUpView.dongPickerView.delegate = self
        signUpView.dongPickerView.dataSource = self
    }
    
    override func bind() {
        let input = SignUpViewModel.Input(
            nameTextFieldDidChanged: signUpView.nameTextField.rx.text.orEmpty.changed.asObservable(),
            nickNameTextFieldDidChanged: signUpView.nickNameTextField.rx.text.orEmpty.changed.distinctUntilChanged().asObservable(),
            siAreaSelected: signUpView.siTextField.rx.text.orEmpty.changed.distinctUntilChanged().asObservable(),
            guAreaSelected: signUpView.guTextField.rx.text.orEmpty.changed.distinctUntilChanged().asObservable(),
            dongAreaSelected: signUpView.dongTextField.rx.text.orEmpty.changed.distinctUntilChanged().asObservable(),
            genderSelected: signUpView.genderSegmentedControl.rx.selectedSegmentIndex.asObservable(),
            dateSelected: signUpView.birthPickerView.rx.date.changed.asObservable(),
            heightFieldDidChanged: signUpView.heightTextField.rx.text.orEmpty.changed.asObservable(),
            weightFieldDidChanged: signUpView.weightTextField.rx.text.orEmpty.changed.asObservable(),
            signUpButtonDidTap: signUpView.signUpButton.rx.tap.asObservable())
        let output = viewModel.transform(input: input)
        
        output.nickNameValidateResult
            .withUnretained(self)
            .bind { (owner, result) in                
                owner.signUpView.nickNameValidateLabel.text = result
            }
            .disposed(by: disposeBag)
        
        output.siData
            .withUnretained(self)
            .subscribe(onNext: { (owner, si) in
                owner.siData = si.areas
            })
            .disposed(by: disposeBag)
        
        output.guData
            .withUnretained(self)
            .subscribe(onNext: { (owner, gu) in
                owner.guData = gu.areas
            })
            .disposed(by: disposeBag)
        
        output.dongData
            .withUnretained(self)
            .subscribe(onNext: { (owner, dong) in
                owner.dongData = dong.areas
            })
            .disposed(by: disposeBag)
        
        output.signUpResult
            .subscribe(onNext: { [weak self] result in
                guard let result = result else {
                    self?.showAlert(title: "회원가입 실패", message: "회원가입에 실패했습니다.", actions: [UIAlertAction(title: "확인", style: .default)])
                    return
                }
                //성공
                self?.coordinator?.popSignUpView()
                print(result)
                print("⭐️")
            })
            .disposed(by: disposeBag)
        
        signUpView.toolBar.items?.last?.rx.tap
            .withUnretained(self)
            .bind { (owner, _) in
                owner.handleSelectedData()
                owner.signUpView.endEditing(true)
            }
            .disposed(by: disposeBag)
        
        signUpView.siTextField.rightView?.rx.tapGesture().when(.recognized)
            .withUnretained(self)
            .bind { (owner, _) in
                owner.signUpView.siTextField.becomeFirstResponder()
                owner.selectedType = .si
            }
            .disposed(by: disposeBag)
        
        signUpView.guTextField.rightView?.rx.tapGesture().when(.recognized)
            .withUnretained(self)
            .bind { (owner, _) in
                owner.signUpView.guTextField.becomeFirstResponder()
                owner.selectedType = .gu
            }
            .disposed(by: disposeBag)
        
        signUpView.dongTextField.rightView?.rx.tapGesture().when(.recognized)
            .withUnretained(self)
            .bind { (owner, _) in
                owner.signUpView.dongTextField.becomeFirstResponder()
                owner.selectedType = .dong
            }
            .disposed(by: disposeBag)
        
        signUpView.yearTitle.rightView?.rx.tapGesture().when(.recognized)
            .withUnretained(self)
            .bind { (owner, _) in
                owner.signUpView.yearTitle.becomeFirstResponder()
                owner.selectedType = .date
            }
            .disposed(by: disposeBag)
        
        signUpView.monthTitle.rightView?.rx.tapGesture().when(.recognized)
            .withUnretained(self)
            .bind { (owner, _) in
                owner.signUpView.monthTitle.becomeFirstResponder()
                owner.selectedType = .date
            }
            .disposed(by: disposeBag)
        
        signUpView.dayTitle.rightView?.rx.tapGesture().when(.recognized)
            .withUnretained(self)
            .bind { (owner, _) in
                owner.signUpView.dayTitle.becomeFirstResponder()
                owner.selectedType = .date
            }
            .disposed(by: disposeBag)
    }
}

extension SignUpViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == signUpView.siPickerView {
            return siData.count
        } else if pickerView == signUpView.guPickerView {
            return guData.count
        } else {
            return dongData.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == signUpView.siPickerView {
            return siData[row].name
        } else if pickerView == signUpView.guPickerView {
            return guData[row].name
        } else {
            return dongData[row].name
        }
    }
}

extension SignUpViewController {
    private func handleSelectedData() {
        switch selectedType {
        case .si: signUpView.siTextField.text = siData[signUpView.siPickerView.selectedRow(inComponent: 0)].name
        case .gu: signUpView.guTextField.text = guData.isEmpty ? "구" :  guData[signUpView.guPickerView.selectedRow(inComponent: 0)].name
        case .dong: signUpView.dongTextField.text = dongData.isEmpty ? "동" :  dongData[signUpView.dongPickerView.selectedRow(inComponent: 0)].name
        case .date:
            let date = signUpView.birthPickerView.date
            signUpView.yearTitle.text = "\(Calendar.current.component(.year, from: date))"
            signUpView.monthTitle.text = "\(Calendar.current.component(.month, from: date))"
            signUpView.dayTitle.text = "\(Calendar.current.component(.day, from: date))"
        case .none:
            return
        }
    }
}
