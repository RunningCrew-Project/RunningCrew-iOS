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
        let recordVC: RecordRunningViewController = RecordRunningViewController(viewModel: RecordRunningViewModel())
        self.navigationController.pushViewController(recordVC, animated: false)
        recordVC.delegate = self
    }
}

extension RecordRunningCoordinator: RecordRunningViewControllerDelegate {
    func showIndividualView() {
        self.navigationController.pushViewController(RunningStartViewController(viewModel: RunningStartViewModel(viewTitle: "개인러닝")), animated: true)
    }
    
    func showCrewView() {
        self.navigationController.pushViewController(MyRunningViewController(), animated: true)
    }
}
