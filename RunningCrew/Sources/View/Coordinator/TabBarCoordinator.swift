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
        setTabBarUI()
    }
}

extension TabBarCoordinator {
    func start() {
        self.window.rootViewController = tabBarController
        tabBarController.tabBar.backgroundColor = .systemBackground
        let items: [TabBarItem] = [.recordRunning, .crew, .alarm, .myPage].sorted { $0.rawValue < $1.rawValue }
        let controllers = items.map { getTabController($0) }
        tabBarController.setViewControllers(controllers, animated: false)
    }
    
    func getTabController(_ item: TabBarItem) -> UINavigationController {
        let navigationController = UINavigationController()
        navigationController.navigationBar.tintColor = .black
        navigationController.tabBarItem = .init(title: item.itemTitleValue(), image: item.itemImageValue(), tag: item.rawValue)
        navigationController.navigationBar.titleTextAttributes = [.font: UIFont(name: "NotoSansKR-Medium", size: 20) ?? UIFont.boldSystemFont(ofSize: 20)]
        setTabCoordinator(of: item, to: navigationController)
        return navigationController
    }
    
    func setTabCoordinator(of item: TabBarItem, to navigationController: UINavigationController) {
        var coordinator: Coordinator?
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
            childCoordinators.append(coordinator)
            coordinator.start()
        }
    }
    
    func setTabBarUI() {
        tabBarController.tabBar.backgroundColor = .white
        tabBarController.tabBar.unselectedItemTintColor = .black
        tabBarController.tabBar.tintColor = .tabBarSelect
        tabBarController.tabBar.layer.borderColor = UIColor.tabBarBorder?.cgColor
        tabBarController.tabBar.layer.borderWidth = 1
        tabBarController.tabBar.clipsToBounds = true
    }
}
