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
        showMyPageView()
    }
}

extension MyPageCoordinator {
    func showMyPageView() {
        let runningRecordRepository = RunningRecordRepository()
        let tokenRepository = TokenRepository()
        let crewRepository = CrewRepository()
        
        let runningService = RunningService(runningRecordRepository: runningRecordRepository, tokenRepository: tokenRepository, crewRepository: crewRepository)
        
        let myPageMyRunningViewModel = MyPageMyRunningViewModel(runningService: runningService)
        let myRunningVC = MyPageMyRunningViewController(viewModel: myPageMyRunningViewModel)
        myRunningVC.tabBarItem.title = "마이러닝"
        
        let calendarVC = MyPageCalendarViewController()
        calendarVC.tabBarItem.title = "캘린더"
        
        let logInService = LogInService.shared
        let myPageViewModel = MyPageViewModel(logInService: logInService)
        
        let myPageVC: MyPageViewController = MyPageViewController(viewControllers: [myRunningVC, calendarVC], myPageViewModel: myPageViewModel)
        self.navigationController.pushViewController(myPageVC, animated: false)
        myPageVC.coordinator = self
    }
}

extension MyPageCoordinator: MyPageViewControllerDelegate {
    func showSettingView() {
        let settingViewModel = SettingViewModel()
        let settingVC = SettingViewController(viewModel: settingViewModel)
        settingVC.coordinator = self
        self.navigationController.pushViewController(settingVC, animated: true)
    }
    
    func showLogInView() {
        let logInService = LogInService.shared
        let logInViewModel = LogInViewModel(logInService: logInService)
        let logInVC = LogInViewController(viewModel: logInViewModel)
        logInVC.coordinator = self
        self.navigationController.pushViewController(logInVC, animated: true)
    }
    
    func showProfileChangeView(id: Int) {
        let profileChangeViewModel = ProfileChangeViewModel(userService: UserService(userRepository: UserRepository(), tokenRepository: TokenRepository()), id: id)
        
        let profileChangeVC = ProfileChangeViewController(viewModel: profileChangeViewModel)
        self.navigationController.pushViewController(profileChangeVC, animated: true)
    }
}

extension MyPageCoordinator: SettingViewControllerDelegate {
    func showMyPage() {
        self.navigationController.popViewController(animated: true)
    }
}

extension MyPageCoordinator: LogInViewControllerDelegate {
    func popLogInView() {
        self.navigationController.popViewController(animated: true)
    }
    
    func showSignUpView(accessToken: String, refreshToken: String) {
        let areaRepository = AreaRepository()
        
        let logInService = LogInService.shared
        let locationService = LocationService(areaRepository: areaRepository)
        
        let signUpViewModel = SignUpViewModel(logInService: logInService, accessToken: accessToken, refreshToken: refreshToken, locationService: locationService, userService: UserService(userRepository: UserRepository(), tokenRepository: TokenRepository()))
        let signUpVC = SignUpViewController(viewModel: signUpViewModel)
        signUpVC.coordinator = self
        self.navigationController.pushViewController(signUpVC, animated: true)
    }
}

extension MyPageCoordinator: SignUpViewControllerDelegate {
    func popSignUpView() {
        self.navigationController.popViewController(animated: true)
    }
}
