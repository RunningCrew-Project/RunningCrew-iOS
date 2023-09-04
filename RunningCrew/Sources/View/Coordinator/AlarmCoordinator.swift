//
//  AlarmCoordinator.swift
//  RunningCrew
//
//  Created by JunHwan Kim on 2023/02/13.
//

import UIKit

final class AlarmCoordinator: Coordinator {

    var navigationController: UINavigationController

    var childCoordinators: [Coordinator] = []

    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showAlarmView()
    }
}

extension AlarmCoordinator {
    func showAlarmView() {
        let alarmService = AlarmService(crewRepository: CrewRepository(), tokenRepository: TokenRepository())
        
        let crewAlarmViewModel = CrewAlarmViewModel(alarmService: alarmService)
        let myRunningAlarmViewModel = MyRunningAlarmViewModel(alarmService: alarmService)
        
        let crewAlarmVC = CrewAlarmViewController(viewModel: crewAlarmViewModel)
        let myRunningAlarmVC = MyRunningAlarmViewController(viewModel: myRunningAlarmViewModel)
        
        crewAlarmVC.tabBarItem.title = "크루"
        myRunningAlarmVC.tabBarItem.title = "마이러닝"
        
        let alarmViewModel = AlarmViewModel()
        let alarmVC: AlarmViewController = AlarmViewController(viewControllers: [crewAlarmVC, myRunningAlarmVC], viewModel: alarmViewModel)
        
        self.navigationController.pushViewController(alarmVC, animated: false)
    }
}
