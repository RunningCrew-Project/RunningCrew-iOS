//
//  MyPageViewController.swift
//  RunningCrew
//
//  Created by JunHwan Kim on 2023/02/13.
//

import UIKit
import RxSwift
import RxCocoa
import RxGesture

protocol MyPageViewControllerDelegate: AnyObject {
    func showSettingView()
    func showLogInView()
    func showProfileChangeView()
}

final class MyPageViewController: BaseViewController {

    weak var coordinator: MyPageViewControllerDelegate?
    
    private var myPageView: MyPageView!
    private var viewModel: MyPageViewModel
    private var viewControllers: [UIViewController]
    
    init(viewControllers: [UIViewController], myPageViewModel: MyPageViewModel) {
        self.viewControllers = viewControllers
        self.viewModel = myPageViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        let items = self.viewControllers.map { vc -> MenuItem in
            let vcTabBarTitle = vc.tabBarItem.title ?? ""
            return MenuItem(title: vcTabBarTitle, isSelect: false)
        }
        
        self.myPageView = MyPageView(items: items)
        self.view = myPageView
    }
    
    override func viewDidLoad() {
        didSelect(indexNum: 0)
        setNavigationBar()
        myPageView.customTabBar.delegate = self
        super.viewDidLoad()
    }
    
    override func bind() {
        let input = MyPageViewModel.Input()
        let output = viewModel.transform(input: input)
        
        output.isLogIn
            .bind { [weak self] isLogIn in
                self?.showNeedLogInView(isLogIn: isLogIn)
            }
            .disposed(by: disposeBag)
        
        myPageView.needLogInTitle.rx.tapGesture().when(.recognized)
            .bind { [weak self] _ in
                self?.coordinator?.showLogInView()
            }
            .disposed(by: disposeBag)
        
        myPageView.profileChangeButton.rx.tap.asObservable()
            .bind { [weak self] _ in
                self?.coordinator?.showProfileChangeView()
            }
            .disposed(by: disposeBag)
    }
}

extension MyPageViewController {
    private func setNavigationBar() {
        let setImage = UIImage(systemName: "gearshape")
        let setButton = UIBarButtonItem(image: setImage, style: .plain, target: self, action: nil)
        self.navigationItem.rightBarButtonItem = setButton
        
        self.navigationItem.title = "마이페이지"
        self.navigationController?.navigationBar.tintColor = .darkModeBasicColor
    }
    
    private func showNeedLogInView(isLogIn: Bool) {
        self.myPageView.pageView.subviews.forEach { view in
            view.isHidden = !isLogIn
        }
        self.myPageView.needLogInLabel.isHidden = isLogIn
        self.myPageView.needLogInTitle.isHidden = isLogIn
        self.myPageView.profileChangeButton.isHidden = !isLogIn
        self.myPageView.profileTitle.isHidden = !isLogIn
    }
}

extension MyPageViewController: CustomTabBarDelegate {
    func didSelect(indexNum: Int) {
        if self.myPageView.needLogInTitle.isHidden == false { return }
        
        let isContainView = myPageView.pageView.subviews.contains(where: {$0.isEqual(viewControllers[indexNum].view)})
        
        if isContainView == false {
            myPageView.pageView.addSubview(viewControllers[indexNum].view)
        }
        
        myPageView.pageView.subviews.forEach { view in
            view.isHidden = viewControllers[indexNum].view != view ? true : false
        }
    }
}
