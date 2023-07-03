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
    
    let goalType: GoalType
    let viewModel: RunningStartViewModel
    
    init(goalType: GoalType, viewModel: RunningStartViewModel) {
        self.goalType = goalType
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
        let textField = GoalTextField(goalType: goalType)
        
        return textField
    }()
    
    lazy var goalLabel: GoalSettingStackView = {
        let goalLabel = GoalSettingStackView(goalType: goalType)
        
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
        goalLabelBindingTextField.rx.text.orEmpty
            .map { [weak self] input -> String? in
                guard let self = self else { return "" }
                
                switch self.goalType {
                case .distance:
                    if input.isEmpty {
                        return "0"
                    }
                    if input == "0" {
                        self.goalLabelBindingTextField.text?.removeLast()
                        return "0"
                    }
                    return input
                case .time:
                    if input.isEmpty {
                        return "00:00"
                    }
                    let len = input.count
                    let paddedStr = String(repeating: "0", count: 4 - len) + input
                    let index1 = paddedStr.index(paddedStr.startIndex, offsetBy: 2)
                    let index2 = paddedStr.index(paddedStr.startIndex, offsetBy: 4)
                    let result = "\(paddedStr[..<index1]):\(paddedStr[index1..<index2])"
                    
                    return result
                }
            }
            .bind(to: self.goalLabel.goalSettingLabelStackView.destinationLabel.rx.text)
            .disposed(by: disposeBag)
        
                
        goalLabelBindingTextField.rx.text.orEmpty
            .asDriver()
            .map({ input in
                if input.contains(".") || input.contains(":") {
                    return input.count <= 5
                } else {
                    return input.count <= 4
                }
            })
            .drive { [weak self] in
                if !$0 {
                    self?.goalLabelBindingTextField.text = String(self?.goalLabelBindingTextField.text?.dropLast() ?? "")
                }
            }.disposed(by: disposeBag)
        
        navigationItem.leftBarButtonItem?.rx.tap
            .bind { self.delegate?.tapCancleButton() }
            .disposed(by: disposeBag)
        
        navigationItem.rightBarButtonItem?.rx.tap
            .bind { [weak self] _ in
                guard let self = self else { return }
                
                switch self.goalType {
                case .distance:
                    viewModel.goalDistance.accept(Float(goalLabelBindingTextField.text ?? "0") ?? 0)
                case .time:
                    let time = (goalLabelBindingTextField.text ?? "00:00").split(separator: ":").map {Int($0)}
                    viewModel.goalHour.accept(time[0] ?? 0)
                    viewModel.goalMinute.accept(time[1] ?? 0)
                }
                
                self.delegate?.tapSettingButton()
            }
            .disposed(by: disposeBag)
    }
}






