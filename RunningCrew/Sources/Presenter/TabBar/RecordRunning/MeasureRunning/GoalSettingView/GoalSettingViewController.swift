//
//  GoalSettingViewController.swift
//  RunningCrew
//
//  Created by JunHwan Kim on 2023/02/27.
//

import UIKit
import RxCocoa
import RxSwift

class GoalSettingViewController: UIViewController {
    
    lazy var goalLabelBindingTextField: GoalTextField = {
       let textField = GoalTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    lazy var goalLabel: GoalSettingLabelStackView = {
       let goalLabel = GoalSettingLabelStackView()
        goalLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return goalLabel
    }()
    
    private var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setNavigationBarItem()
        setBindingTextField()
        setGoalLabel()
        textFieldBingLabel()
        navigationItem.title = "러닝 목표 설정"
    }
    
    func setBindingTextField() {
        view.addSubview(goalLabelBindingTextField)
        goalLabelBindingTextField.becomeFirstResponder()
        NSLayoutConstraint.activate([
            goalLabelBindingTextField.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            goalLabelBindingTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    func setGoalLabel() {
        view.addSubview(goalLabel)
        NSLayoutConstraint.activate([
            goalLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            goalLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    func setNavigationBarItem() {
        let cancelButton = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(tapCancelButton))
        let doneButton = UIBarButtonItem(title: "확인", style: .plain, target: self, action: #selector(tapDoneButton))
        navigationItem.leftBarButtonItem = cancelButton
        navigationItem.rightBarButtonItem = doneButton
        navigationController?.navigationBar.tintColor = .black
    }
    
    func textFieldBingLabel() {
        goalLabelBindingTextField.rx.text.orEmpty
            .asDriver()
            .drive(onNext: { text in
                if text.isEmpty {
                    self.goalLabel.destinationLabel.text = "0"
                } else {
                    self.goalLabel.destinationLabel.text = text
                }
            })
            .disposed(by: disposeBag)
    }
    
    @objc func tapCancelButton() {
        closeKeyboard {
            self.dismiss(animated: false)
        }
    }
    
    func closeKeyboard(completion: @escaping()-> ()) {
        view.endEditing(true)
        completion()
    }
    
    @objc func tapDoneButton() {
        
    }
    
    deinit {
        print("deinit setting goal view")
    }
}
