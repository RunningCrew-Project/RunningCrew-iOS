//
//  CrewCoordinator.swift
//  RunningCrew
//
//  Created by JunHwan Kim on 2023/02/13.
//

import Foundation
import UIKit

final class CrewCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let crewViewModel = CrewViewModel()
        let crewVC = CrewViewController(viewModel: crewViewModel)
        crewVC.coordinator = self
        navigationController.pushViewController(crewVC, animated: false)
    }
}

extension CrewCoordinator: CrewViewControllerDelegate {
    func showCrewGenerateView() {
        let crewGenerateViewModel = CrewGenerateViewModel()
        let crewGenerateVC = CrewGenerateViewController(viewModel: crewGenerateViewModel)
        crewGenerateVC.modalPresentationStyle = .fullScreen
        crewGenerateVC.coordinator = self
        self.navigationController.present(crewGenerateVC, animated: true)
    }
    
    func showCrewJoinView() {
        let crewJoinVC = CrewJoinViewController()
        crewJoinVC.modalPresentationStyle = .fullScreen
        self.navigationController.present(crewJoinVC, animated: true)
    }
}

extension CrewCoordinator: CrewGenerateViewControllerDelegate {
    func closeCrewGenerateView() {
        self.navigationController.dismiss(animated: true)
    }
}
