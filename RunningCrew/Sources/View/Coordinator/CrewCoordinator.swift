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
       showCrewView()
    }
}

extension CrewCoordinator {
    func showCrewView() {
        let runningRecordRepository = RunningRecordRepository()
        let tokenRepository = TokenRepository()
        let crewRepository = CrewRepository()
        
        let runnningService = RunningService(runningRecordRepository: runningRecordRepository, tokenRepository: tokenRepository, crewRepository: crewRepository)
        let logInService = LogInService.shared
        let locationService = LocationService(areaRepository: AreaRepository())
        
        let crewViewModel = CrewViewModel(logInService: logInService, runningService: runnningService, locationService: locationService)
        let crewVC = CrewViewController(viewModel: crewViewModel)
        crewVC.coordinator = self
        navigationController.pushViewController(crewVC, animated: false)
    }
}

extension CrewCoordinator: CrewViewControllerDelegate {
    func showCrewSearchView() {
        
    }
    
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
        self.navigationController.dismiss(animated: false)
    }
}
