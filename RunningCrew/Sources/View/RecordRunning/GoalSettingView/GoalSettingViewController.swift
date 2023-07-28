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

protocol GoalSettingViewControllerDelegate: AnyObject {
    func tapCancleButton()
    func tapSettingButton(goalType: GoalType)
}

final class GoalSettingViewController: BaseViewController {
    
    weak var coordinator: GoalSettingViewControllerDelegate?
    
    private let viewModel: GoalSettingViewModel
    private var goalSettingView: GoalSettingView!
    
    init(viewModel: GoalSettingViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.goalSettingView = GoalSettingView()
        self.view = goalSettingView
        
        setupNavigationBarAndTabBar()
    }
    
    override func bind() {
        let input = GoalSettingViewModel.Input(
            nextButtonDidTap: goalSettingView.goalSettingStackView.nextButton.rx.tap.asObservable(),
            beforeButtonDidTap: goalSettingView.goalSettingStackView.beforeButton.rx.tap.asObservable(),
            textFieldDidChanged: goalSettingView.goalLabelBindingTextField.rx.text.asObservable(),
            navigationRightButtonDidTap: navigationItem.rightBarButtonItem?.rx.tap.asObservable())
        let output = viewModel.transform(input: input)
        
        output.goalText
            .bind { [weak self] type in
                switch type {
                case .distance(let kilometer):
                    self?.goalSettingView.goalLabelBindingTextField.text = "\(Int(kilometer * 100))"
                    self?.goalSettingView.goalSettingStackView.goalLabel.text = String(format: "%05.2f", kilometer)
                case .time(let hour, let minute):
                    self?.goalSettingView.goalLabelBindingTextField.text = "\(hour * 100 + minute)"
                    self?.goalSettingView.goalSettingStackView.goalLabel.text = String(format: "%02d", hour) + ":" + String(format: "%02d", minute)
                }
            }
            .disposed(by: disposeBag)
        
        output.goalType
            .bind { [weak self] type in
                self?.goalSettingView.goalSettingStackView.changeGoalType(type: type)
                self?.goalSettingView.goalLabelBindingTextField.text = ""
                
                switch type {
                case .distance: self?.goalSettingView.goalSettingStackView.goalLabel.text = "00.00"
                case .time: self?.goalSettingView.goalSettingStackView.goalLabel.text = "00:00"
                }
            }
            .disposed(by: disposeBag)
        
        output.finishSetting?
            .bind { [weak self] goalType in
                self?.coordinator?.tapSettingButton(goalType: goalType)
            }
            .disposed(by: disposeBag)
        
        navigationItem.leftBarButtonItem?.rx.tap
            .bind { [weak self] _ in self?.coordinator?.tapCancleButton() }
            .disposed(by: disposeBag)
    }
}

extension GoalSettingViewController {
    private func setupNavigationBarAndTabBar() {
        navigationItem.title = "러닝 목표 설정"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "취소", style: .plain, target: self, action: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "설정", style: .plain, target: self, action: nil)
        navigationController?.navigationBar.tintColor = .darkModeBasicColor
    }
}
