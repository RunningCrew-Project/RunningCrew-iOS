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
    private let viewModel: RunningStartViewModel
    private var goalSettingView: GoalSettingView!
    
    init(viewModel: RunningStartViewModel) {
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
        let nextButtonDidTap = goalSettingView.goalLabel.nextButton.rx.tap.asObservable()
        let beforeButtonDidTap = goalSettingView.goalLabel.beforeButton.rx.tap.asObservable()
        let navigationRightButtonDidTap = navigationItem.rightBarButtonItem?.rx.tap.map {
            self.goalSettingView.goalLabel.destinationLabel.text ?? "" }.asObservable()
        
        let input = RunningStartViewModel.Input(
            nextButtonDidTap: nextButtonDidTap,
            beforeButtonDidTap: beforeButtonDidTap,
            navigationRightButtonDidTap: navigationRightButtonDidTap)
        
        let output = viewModel.transform(input: input)
        
        output.goalType
            .bind { [weak self] type in
                self?.goalSettingView.goalLabel.changeGoalType(type: type)
            }
            .disposed(by: disposeBag)
        
        goalSettingView.goalLabelBindingTextField.rx.text.orEmpty
            .map { [weak self] input -> String? in
                guard let self = self else { return "" }

                switch self.viewModel.goalType.value {
                case .distance:
                    return self.convertDistanceString(input: input)
                case .time:
                    return self.convertTimeString(input: input)
                }
            }
            .bind(to: goalSettingView.goalLabel.destinationLabel.rx.text)
            .disposed(by: disposeBag)
        
        navigationItem.leftBarButtonItem?.rx.tap
            .bind { self.delegate?.tapCancleButton() }
            .disposed(by: disposeBag)
        
        navigationItem.rightBarButtonItem?.rx.tap
            .bind { self.delegate?.tapSettingButton() }
            .disposed(by: disposeBag)
    }
}

extension GoalSettingViewController {
    private func convertDistanceString(input: String) -> String? {
        if input.count == 0 {
            return "00.00"
        } else if input.count == 1 {
            return "00.0" + input
        } else if input.count == 2 {
            return "00." + input
        } else if input.count == 3 {
            return "0" + String(input.prefix(1)) + "." + String(input.suffix(2))
        } else if input.count == 4 {
            return String(input.prefix(2)) + "." + String(input.suffix(2))
        } else {
            return goalSettingView.goalLabel.destinationLabel.text
        }
    }
    
    private func convertTimeString(input: String) -> String? {
        if input.count == 0 {
            return "00:00"
        } else if input.count == 1 {
            return "00:0" + input
        } else if input.count == 2 {
            return "00:" + input
        } else if input.count == 3 {
            return "0" + String(input.prefix(1)) + ":" + String(input.suffix(2))
        } else if input.count == 4 {
            return String(input.prefix(2)) + ":" + String(input.suffix(2))
        } else {
            return goalSettingView.goalLabel.destinationLabel.text
        }
    }
    
    private func setupNavigationBarAndTabBar() {
        navigationItem.title = "러닝 목표 설정"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "취소", style: .plain, target: self, action: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "설정", style: .plain, target: self, action: nil)
        navigationController?.navigationBar.tintColor = .darkModeBasicColor
    }
}
