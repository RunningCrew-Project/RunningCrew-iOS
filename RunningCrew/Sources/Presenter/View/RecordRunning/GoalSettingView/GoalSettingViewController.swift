//
//  GoalSettingViewController.swift
//  RunningCrew
//
//  Created by JunHwan Kim on 2023/02/27.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift

protocol GoalSettingViewDelegate: AnyObject {
    func tapCancleButton()
    func tapSettingButton()
}

class GoalSettingViewController: BaseViewController {
    
    weak var delegate: GoalSettingViewDelegate?

    let viewModel: RunningStartViewModel
    
    init(viewModel: RunningStartViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.title = "러닝 목표 설정"
    }
    
    lazy var goalLabelBindingTextField: GoalTextField = {
        let textField = GoalTextField(goalType: viewModel.goalType)
        
        return textField
    }()
    
    lazy var goalLabel: GoalSettingStackView = {
        let goalLabel = GoalSettingStackView(goalType: viewModel.goalType)
        
        return goalLabel
    }()
    
    deinit {
        print("deinit setting goal view")
    }
    
    override func setView() {
        goalLabelBindingTextField.becomeFirstResponder()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "취소", style: .plain, target: self, action: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "설정", style: .plain, target: self, action: nil)
        navigationController?.navigationBar.tintColor = .darkModeBasicColor
    }
    
    override func setAddView() {
        view.addSubview(goalLabelBindingTextField)
        view.addSubview(goalLabel)
    }
    
    override func setConstraint() {
        goalLabelBindingTextField.snp.makeConstraints {
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            $0.centerX.equalToSuperview()
        }
        
        goalLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
    
    override func bind() {
        let input = RunningStartViewModel.Input(
            nextButtonDidTap: goalLabel.nextButton.rx.tap.asObservable(),
            beforeButtonDidTap: goalLabel.beforeButton.rx.tap.asObservable(),
            navigationRightButtonDidTap: navigationItem.rightBarButtonItem?.rx.tap
                .map { self.goalLabel.goalSettingLabelStackView.destinationLabel.text ?? "" })
        
        let output = viewModel.transform(input: input)
        
        output.goalText
            .drive(goalLabel.goalSettingLabelStackView.destinationLabel.rx.text)
            .disposed(by: disposeBag)
        
        goalLabelBindingTextField.rx.text.orEmpty
            .map { [weak self] input -> String? in
                guard let self = self else { return "" }
                
                switch self.viewModel.goalType.value {
                case .distance:
                    if input.isEmpty {
                        return "0.00"
                    } else if input.count <= 2 {
                        return input + ".00"
                    } else {
                        goalLabelBindingTextField.text = String(input.prefix(2))
                        return (goalLabelBindingTextField.text ?? "0") + ".00"
                    }
                case .time:
                    if input.isEmpty {
                        return "00:00"
                    } else if input.count <= 4 {
                        let string = String(format: "%.4d", Int(input) ?? 0)
                        return String(string.prefix(2)) + ":" + String(string.suffix(2))
                    } else {
                        goalLabelBindingTextField.text = String(input.prefix(4))
                        return (goalLabelBindingTextField.text ?? "00").prefix(2) + ":" + (goalLabelBindingTextField.text ?? "00").suffix(2)
                    }
                }
            }
            .bind(to: self.goalLabel.goalSettingLabelStackView.destinationLabel.rx.text)
            .disposed(by: disposeBag)
        
        navigationItem.leftBarButtonItem?.rx.tap
            .bind { self.delegate?.tapCancleButton() }
            .disposed(by: disposeBag)
        
        navigationItem.rightBarButtonItem?.rx.tap
            .bind { self.delegate?.tapSettingButton() }
            .disposed(by: disposeBag)
    }
}
