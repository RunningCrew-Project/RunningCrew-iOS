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
}

extension RecordRunningCoordinator {
    func showRecordRunningViewController() {
        let locationService = LocationService(areaRepository: AreaRepository())
        let logInService = LogInService.shared
        let viewModel = RecordRunningViewModel(logInService: logInService, locationService: locationService)
        let recordRunningVC: RecordRunningViewController = RecordRunningViewController(viewModel: viewModel)
        recordRunningVC.coordinator = self
        self.navigationController.pushViewController(recordRunningVC, animated: false)
    }
}

extension RecordRunningCoordinator: RecordRunningViewControllerDelegate {
    func showIndividualView() {
        let locationService = LocationService(areaRepository: AreaRepository())
        let motionService = MotionService()
        let logInService = LogInService.shared
        let individualViewModel = IndividualRunningViewModel(locationService: locationService, motionService: motionService, logInService: logInService)
        let individualRunningVC: IndividualRunningViewController = IndividualRunningViewController(viewModel: individualViewModel)
        individualRunningVC.coordinator = self
        self.navigationController.pushViewController(individualRunningVC, animated: false)
    }
    
    func showCrewView() {
        let runningRecordRepository = RunningRecordRepository()
        let tokenRepository = TokenRepository()
        let crewRepository = CrewRepository()
        
        let runningService = RunningService(runningRecordRepository: runningRecordRepository, tokenRepository: tokenRepository, crewRepository: crewRepository)
        let crewRunningViewModel = CrewRunningViewModel(runningService: runningService)
        let crewRunningVC = CrewRunningViewController(viewModel: crewRunningViewModel)
        self.navigationController.pushViewController(crewRunningVC, animated: false)
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
        let locationService = LocationService(areaRepository: AreaRepository())
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
    func showSaveRunningRecordView(runningRecord: RunningRecord) {
        self.navigationController.viewControllers.last?.dismiss(animated: false)
        self.navigationController.popViewController(animated: false)
        
        let runningRecordRepository = RunningRecordRepository()
        let tokenRepository = TokenRepository()
        let crewRepository = CrewRepository()
        
        let runningService = RunningService(runningRecordRepository: runningRecordRepository, tokenRepository: tokenRepository, crewRepository: crewRepository)
        let logInService = LogInService.shared
        let locationService = LocationService(areaRepository: AreaRepository())
        let saveRecordViewModel = SaveRecordViewModel(runningRecord: runningRecord, locationService: locationService, logInService: logInService, runningService: runningService)
        let saveRecordRunningVC = SaveRecordRunningViewController(viewModel: saveRecordViewModel)
        saveRecordRunningVC.modalPresentationStyle = .fullScreen
        saveRecordRunningVC.coordinator = self
        self.navigationController.present(saveRecordRunningVC, animated: false)
    }
}

extension RecordRunningCoordinator: SaveRecordRunningViewControllerDelegate {
    func dismissView() {
        self.navigationController.viewControllers.last?.dismiss(animated: false)
    }
}
