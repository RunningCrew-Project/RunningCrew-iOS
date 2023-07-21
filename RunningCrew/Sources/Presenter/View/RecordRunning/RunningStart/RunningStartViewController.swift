//
//  MeasureRunningViewController.swift
//  RunningCrew
//
//  Created by JunHwan Kim on 2023/02/21.
//

import UIKit
import RxCocoa
import RxSwift
import RxGesture

protocol RunningStartViewControllerDelegate: AnyObject {
    func showGoalSettingView(viewModel: RunningStartViewModel)
    func showRecordView(goalType: GoalType, goal: String)
}

final class RunningStartViewController: BaseViewController {
    
    weak var delegate: RunningStartViewControllerDelegate?
    private let viewModel: RunningStartViewModel
    private var runningStartView: RunningStartView!
    
    init(viewModel: RunningStartViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        self.runningStartView = RunningStartView()
        self.view = runningStartView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavigationBarAndTabBar()
    }
    
    override func viewWillLayoutSubviews() {
        runningStartView.setViewStyle()
    }
    
    override func bind() {
        let nextButtonDidTap = runningStartView.goalSettingStackView.nextButton.rx.tap.asObservable()
        let beforeButtonDidTap = runningStartView.goalSettingStackView.beforeButton.rx.tap.asObservable()
        
        let input = RunningStartViewModel.Input(nextButtonDidTap: nextButtonDidTap,
                                                beforeButtonDidTap: beforeButtonDidTap,
                                                navigationRightButtonDidTap: nil)
        
        let output = viewModel.transform(input: input)
        
        output.goalType
            .bind { [weak self] type in
                self?.runningStartView.goalSettingStackView.changeGoalType(type: type)
            }
            .disposed(by: disposeBag)
        
        output.goalText
            .bind { [weak self] text in
                self?.runningStartView.goalSettingStackView.destinationLabel.text = text
            }
            .disposed(by: disposeBag)
        
        runningStartView.goalSettingStackView.destinationLabel.rx.tapGesture()
            .when(.recognized)
            .bind { _ in self.delegate?.showGoalSettingView(viewModel: self.viewModel) }
            .disposed(by: disposeBag)
    
        runningStartView.startButton.rx.tap
            .bind { _ in
                if MotionManager.shared.isNeedAuthSetting() {
                    self.showMoveSettingAlert()
                } else {
                    self.delegate?.showRecordView(goalType: self.viewModel.goalType.value,
                                                  goal: self.runningStartView.goalSettingStackView.destinationLabel.text ?? "")
                }
            }
            .disposed(by: disposeBag)
    }
}

extension RunningStartViewController {
    private func setupNavigationBarAndTabBar() {
        self.navigationItem.title = "개인 러닝"
        self.navigationController?.navigationBar.tintColor = .darkModeBasicColor
        self.tabBarController?.tabBar.isHidden = true
    }
    
    private func showMoveSettingAlert() {
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        let confirmAction = UIAlertAction(title: "예", style: .default) {_ in
            guard let url = URL(string: UIApplication.openSettingsURLString) else { return }

            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            }
        }
        
        showAlert(title: "동작 및 피트니스 권한", message: "걸음수 데이터 측정을 위해 데이터 접근 권한이 필요합니다. 설정으로 이동하시겠습니까?", actions: [cancelAction, confirmAction])
    }
}
