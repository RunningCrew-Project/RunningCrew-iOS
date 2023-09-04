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

protocol IndividualRunningViewControllerDelegate: AnyObject {
    func showGoalSettingView(goalType: GoalType)
    func showRecordView(goalType: GoalType)
}

final class IndividualRunningViewController: BaseViewController {
    
    weak var coordinator: IndividualRunningViewControllerDelegate?
    
    private let viewModel: IndividualRunningViewModel
    private var individualRunningView: IndividualRunningView!
    private let goalSetting: BehaviorRelay<GoalType> = BehaviorRelay<GoalType>(value: .distance(kilometer: 5.0))
    
    init(viewModel: IndividualRunningViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        self.individualRunningView = IndividualRunningView()
        self.view = individualRunningView
        
        setupNavigationBarAndTabBar()
    }
    
    override func viewWillLayoutSubviews() {
        individualRunningView.setUpUI()
    }
    
    override func bind() {
        let input = IndividualRunningViewModel.Input(
            goalLabelDidTap: individualRunningView.goalSettingStackView.goalLabel.rx.tapGesture().when(.recognized),
            nextButtonDidTap: individualRunningView.goalSettingStackView.nextButton.rx.tap.asObservable(),
            beforeButtonDidTap: individualRunningView.goalSettingStackView.beforeButton.rx.tap.asObservable(),
            startButtonDidTap: individualRunningView.startButton.rx.tap.asObservable(),
            goalSettingDidChanged: goalSetting.asObservable())
        let output = viewModel.transform(input: input)
        
        output.goalType
            .bind { [weak self] type in
                self?.individualRunningView.goalSettingStackView.changeGoalType(type: type)
                
                var text: String
                
                switch type {
                case .distance(let kilometer):
                    text = String(format: "%05.2f", kilometer)
                case .time(let hour, let minute):
                    text = String(format: "%.2d", hour) + ":" + String(format: "%.2d", minute)
                }
                
                self?.individualRunningView.goalSettingStackView.goalLabel.text = text
            }
            .disposed(by: disposeBag)
        
        output.canStartButton
            .withUnretained(self)
            .bind { (owner, result) in
                if result.possible {
                    owner.showMoveSettingAlert()
                } else {
                    owner.coordinator?.showRecordView(goalType: result.goalType)
                }
            }
            .disposed(by: disposeBag)
        
        output.location
            .withUnretained(self)
            .subscribe(onNext: { (owner, location) in
                owner.individualRunningView.cameraUpdate(latitude: location.latitude, longitude: location.longitude)
            })
            .disposed(by: disposeBag)
        
        output.goalSettingType
            .withUnretained(self)
            .bind { (owner, goalType) in
                owner.coordinator?.showGoalSettingView(goalType: goalType)
            }
            .disposed(by: disposeBag)
        
        if output.isLogIn == false {
            Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance).take(1)
                .withUnretained(self)
                .bind { (owner, _) in owner.individualRunningView.showToast(message: "로그아웃 상태입니다.\n로그아웃 상태에서는 런닝을 저장할 수 없습니다.", position: .top) }
                .disposed(by: disposeBag)
        }
    }
}

extension IndividualRunningViewController {
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

extension IndividualRunningViewController {
    func passGoalType(goalType: GoalType) {
        goalSetting.accept(goalType)
    }
}
