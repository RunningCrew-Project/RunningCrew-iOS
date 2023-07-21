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
        let crewAlarmVC = CrewAlarmViewController()
        let myRunningVC = MyRunningViewController()
        
        crewAlarmVC.tabBarItem.title = "크루"
        myRunningVC.tabBarItem.title = "마이러닝"
        
        let alarmVC: AlarmViewController = AlarmViewController(viewControllers: [crewAlarmVC, myRunningVC])
        
        self.navigationController.pushViewController(alarmVC, animated: false)
    }
    
    
}
