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
        let mypageVC: MyPageViewController = .init()
        let myrunningVC = MyPageMyRunningViewController()
        myrunningVC.tabBarItem.title = "마이러닝"
        let calendarVC = MyPageCalendarViewController()
        calendarVC.tabBarItem.title = "캘린더"
        mypageVC.setItems(items: [myrunningVC, calendarVC])
        self.navigationController.pushViewController(mypageVC, animated: false)
        
        
        
        
    }
    
    
}
