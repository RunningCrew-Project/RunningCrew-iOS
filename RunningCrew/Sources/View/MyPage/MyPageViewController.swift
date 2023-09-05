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
    func showProfileChangeView(id: Int)
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
        setNavigationBar()
        myPageView.customTabBar.delegate = self
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        didSelect(indexNum: 0)
    }
    
    override func bind() {
        let settingButtonDidTap = navigationItem.rightBarButtonItem?.rx.tap.asObservable()
        let profileChangeButtonDidTap = myPageView.profileChangeButton.rx.tap.asObservable()
        
        let input = MyPageViewModel.Input(settingButtonDidTap: settingButtonDidTap, profileChangeButtonDidTap: profileChangeButtonDidTap)
        let output = viewModel.transform(input: input)
        
        output.settingButtonResult?
            .bind { [weak self] _ in
                self?.coordinator?.showSettingView()
            }
            .disposed(by: disposeBag)
        
        output.profileButtonResult
            .bind { [weak self] id in
                guard let id = id else { return }
                self?.coordinator?.showProfileChangeView(id: id)
            }
            .disposed(by: disposeBag)
        
        output.isLogIn
            .subscribe(onNext: { [weak self] isLogIn in
                self?.showNeedLogInView(isLogIn: isLogIn)
            })
            .disposed(by: disposeBag)
        
        output.me
            .subscribe(onNext: { [weak self] me in
                guard let me = me else { return }
                self?.myPageView.configure(me: me)
            })
            .disposed(by: disposeBag)
        
        myPageView.needLogInTitle.rx.tapGesture().when(.recognized)
            .bind { [weak self] _ in
                self?.coordinator?.showLogInView()
            }
            .disposed(by: disposeBag)
    }
}

extension MyPageViewController {
    private func setNavigationBar() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gearshape"), style: .plain, target: self, action: nil)
        self.navigationItem.title = "마이페이지"
        self.navigationController?.navigationBar.tintColor = .darkModeBasicColor
    }
    
    private func showNeedLogInView(isLogIn: Bool) {
        self.myPageView.needLogInTitle.isHidden = isLogIn
        self.myPageView.profileTitle.isHidden = !isLogIn
        self.myPageView.profileChangeButton.isHidden = !isLogIn
    }
}

extension MyPageViewController: CustomTabBarDelegate {
    func didSelect(indexNum: Int) {
        if let lastView = myPageView.pageView.subviews.last {
            lastView.removeFromSuperview()
        }
        
        if myPageView.needLogInTitle.isHidden == false {
            myPageView.needLogInView.frame = myPageView.pageView.bounds
            myPageView.pageView.addSubview(myPageView.needLogInView)
        } else {
            guard let newView = viewControllers[indexNum].view else { return }
            newView.frame = myPageView.pageView.bounds
            myPageView.pageView.addSubview(newView)
        }
    }
}
