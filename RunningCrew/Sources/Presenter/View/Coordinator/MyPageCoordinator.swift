//
//  MyPageCoordinator.swift
//  RunningCrew
//
//  Created by JunHwan Kim on 2023/02/13.
//

import UIKit

final class MyPageCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    
    var childCoordinators: [Coordinator] = []
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let myRunningVC = MyPageMyRunningViewController()
        let calendarVC = MyPageCalendarViewController()
        let myPageVC: MyPageViewController = MyPageViewController(viewControllers: [myRunningVC, calendarVC])
        self.navigationController.pushViewController(myPageVC, animated: false)
        myPageVC.delegate = self
    }
}

extension MyPageCoordinator: MyPageViewControllerDelegate {
    func showSettingView() {
        
    }
    
    func showProfileChangeView() {
        let profileChangeVC = ProfileChangeViewController()
        self.navigationController.pushViewController(profileChangeVC, animated: true)
    }
}
