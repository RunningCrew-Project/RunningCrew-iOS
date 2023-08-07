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
        
        let userRepository = UserRepository()
        let logInService = LogInService(userRepository: userRepository)
        let myPageViewModel = MyPageViewModel(logInService: logInService)
        
        let myPageVC: MyPageViewController = MyPageViewController(viewControllers: [myRunningVC, calendarVC], myPageViewModel: myPageViewModel)
        self.navigationController.pushViewController(myPageVC, animated: false)
        myPageVC.coordinator = self
    }
}

extension MyPageCoordinator: MyPageViewControllerDelegate {
    func showSettingView() {
        
    }
    
    func showLogInView() {
        let userRepository = UserRepository()
        let logInService = LogInService(userRepository: userRepository)
        let logInViewModel = LogInViewModel(logInService: logInService)
        let logInVC = LogInViewController(viewModel: logInViewModel)
        logInVC.coordinator = self
        self.navigationController.pushViewController(logInVC, animated: true)
    }
    
    func showProfileChangeView() {
        let profileChangeVC = ProfileChangeViewController()
        self.navigationController.pushViewController(profileChangeVC, animated: true)
    }
}

extension MyPageCoordinator: LogInViewControllerDelegate {
    func showMyPageView() {
        self.navigationController.popViewController(animated: true)
    }
    
    func showSignUpView(accessToken: String, refreshToken: String) {
        let userRepository = UserRepository()
        let logInService = LogInService(userRepository: userRepository)
        let signUpViewModel = SignUpViewModel(logInService: logInService, accessToken: accessToken, refreshToken: refreshToken)
        let signUpVC = SignUpViewController(viewModel: signUpViewModel)
        self.navigationController.pushViewController(signUpVC, animated: true)
    }
}
