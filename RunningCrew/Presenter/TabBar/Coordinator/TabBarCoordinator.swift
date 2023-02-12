//
//  TabBarCoordinator.swift
//  RunningCrew
//
//  Created by JunHwan Kim on 2023/02/12.
//

import UIKit

final class TabBarCoordinator {
    var window: UIWindow
    var tabBarController: UITabBarController
    var childCoordinators: [Coordinator]
    
    init(_ window: UIWindow) {
        self.window = window
        self.tabBarController = UITabBarController()
        self.childCoordinators = []
    }
    
    func start() {
        self.window.rootViewController = tabBarController
        let items: [TabBarItem] = [.recordRunning, .crew, .alarm, .myPage].sorted { $0.rawValue < $1.rawValue }
        print(items[1].itemTitleValue())
        let controllers = items.map { getTabController($0) }
        
        tabBarController.setViewControllers(controllers, animated: true)
    }
    
    func getTabController(_ item: TabBarItem) -> UINavigationController {
        let navigationController = UINavigationController()
        navigationController.setNavigationBarHidden(true, animated: false)
        navigationController.tabBarItem = .init(title: item.itemTitleValue(), image: nil, tag: item.rawValue)
        setTabCoordinator(of: item, to: navigationController)
        return navigationController
    }
    
    func setTabCoordinator(of item: TabBarItem, to navigationController: UINavigationController) {
        var coordinator: Coordinator? = nil
        switch item {
        case .recordRunning:
            coordinator = RecordRunningCoordinator(navigationController)
        case .crew:
            coordinator = CrewCoordinator(navigationController)
        case .alarm:
            coordinator = AlarmCoordinator(navigationController)
        case .myPage:
            coordinator = MyPageCoordinator(navigationController)
        }
        if let coordinator = coordinator {
            coordinator.start()
        }
    }
    
}
