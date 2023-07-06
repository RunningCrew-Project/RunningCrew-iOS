//
//  RecordRunningCoordinator.swift
//  RunningCrew
//
//  Created by JunHwan Kim on 2023/02/12.
//

import UIKit
import CoreLocation

/// Coordinator패턴
/// 화면전환 메서드를 클래스 및 프로토콜 델리게이트 패턴으로 빼서 뷰컨트롤러의 의존성을 낮춘 -> 뷰모델인데 화면 전환(데이터전달과 같은 기능들 포함) 메서드만 담당한다.


final class RecordRunningCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator]
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.childCoordinators = []
    }
    
    func start() {
        showRecordRunningViewController()
    }

    deinit {
        print("deinit recordRunningCoordinator")
    }
    
}

extension RecordRunningCoordinator {
    func showRecordRunningViewController() {
        let recordRunningVC: RecordRunningViewController = RecordRunningViewController(viewModel: RecordRunningViewModel())
        recordRunningVC.delegate = self
        self.navigationController.pushViewController(recordRunningVC, animated: false)
    }
}

extension RecordRunningCoordinator: RecordRunningViewControllerDelegate {
    func showIndividualView() {
        let runningStartVC: RunningStartViewController = RunningStartViewController(viewModel: RunningStartViewModel())
        runningStartVC.delegate = self
        self.navigationController.pushViewController(runningStartVC, animated: true)
    }
    
    func showCrewView() {
        let myrunningVC: MyRunningViewController = MyRunningViewController()
        self.navigationController.pushViewController(myrunningVC, animated: true)
    }
}

extension RecordRunningCoordinator: RunningStartViewControllerDelegate {
    func showGoalSettingView(viewModel: RunningStartViewModel) {
        let goalSettingVC = GoalSettingViewController(viewModel: viewModel)
        goalSettingVC.delegate = self
        self.navigationController.pushViewController(goalSettingVC, animated: false)
    }
    
    func showRecordView(goalType: GoalType, goal: String) {
        let recordVC = RecordViewController(viewModel: RecordViewModel(goalType: goalType, goal: goal))
        recordVC.modalPresentationStyle = .fullScreen
        self.navigationController.present(recordVC, animated: false)
    }
}

extension RecordRunningCoordinator: GoalSettingViewDelegate {
    func tapCancleButton() {
        self.navigationController.popViewController(animated: true)
    }
    
    func tapSettingButton() {
        self.navigationController.popViewController(animated: true)
    }
}
