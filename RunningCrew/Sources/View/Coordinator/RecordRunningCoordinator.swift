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
        let locationService = LocationService()
        let viewModel = RecordRunningViewModel(locationService: locationService)
        let recordRunningVC: RecordRunningViewController = RecordRunningViewController(viewModel: viewModel)
        recordRunningVC.coordinator = self
        self.navigationController.pushViewController(recordRunningVC, animated: false)
    }
}

extension RecordRunningCoordinator: RecordRunningViewControllerDelegate {
    func showIndividualView() {
        let locationService = LocationService()
        let motionService = MotionService()
        let individualViewModel = IndividualRunningViewModel(locationService: locationService, motionService: motionService)
        let individualRunningVC: IndividualRunningViewController = IndividualRunningViewController(viewModel: individualViewModel)
        individualRunningVC.coordinator = self
        self.navigationController.pushViewController(individualRunningVC, animated: false)
    }
    
    func showCrewView() {
        let myrunningVC: MyRunningViewController = MyRunningViewController()
        self.navigationController.pushViewController(myrunningVC, animated: false)
    }
}

extension RecordRunningCoordinator: IndividualRunningViewControllerDelegate {
    func showGoalSettingView(goalType: GoalType) {
        let goalSettingViewModel = GoalSettingViewModel(goalType: goalType)
        let goalSettingVC = GoalSettingViewController(viewModel: goalSettingViewModel)
        goalSettingVC.coordinator = self
        self.navigationController.pushViewController(goalSettingVC, animated: false)
    }
    
    func showRecordView(goalType: GoalType) {
        let locationService = LocationService()
        let motionService = MotionService()
        let recordViewModel = RecordViewModel(goalType: goalType, locationService: locationService, motionService: motionService)
        let recordVC = RecordViewController(viewModel: recordViewModel)
        recordVC.modalPresentationStyle = .fullScreen
        recordVC.coordinator = self
        self.navigationController.present(recordVC, animated: false)
    }
}

extension RecordRunningCoordinator: GoalSettingViewControllerDelegate {
    func tapCancleButton() {
        self.navigationController.popViewController(animated: false)
    }
    
    func tapSettingButton(goalType: GoalType) {
        guard let individualRunningVC = self.navigationController.viewControllers.last(where: { $0 is IndividualRunningViewController }) as? IndividualRunningViewController else { return }
        individualRunningVC.passGoalType(goalType: goalType)
        
        self.navigationController.popViewController(animated: false)
    }
}

extension RecordRunningCoordinator: RecordViewControllerDelegate {    
    func finishRunning(path: [(Double, Double)]) {
        self.navigationController.viewControllers.last?.dismiss(animated: false)
        self.navigationController.popViewController(animated: false)
        
        let saveRecordRunningVC = SaveRecordRunningViewController(viewModel: SaveRecordViewModel(path: path))
        saveRecordRunningVC.modalPresentationStyle = .fullScreen
        self.navigationController.present(saveRecordRunningVC, animated: false)
    }
}
