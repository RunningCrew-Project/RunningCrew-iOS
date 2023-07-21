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
        let vc = CrewViewController()
        navigationController.pushViewController(vc, animated: false)
    }
    func presentCrewGenerateViewController(_ viewController: UIViewController) {
        let vc = CrewGenerateViewController()
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        viewController.present(nav, animated: true)
    }
    
}
