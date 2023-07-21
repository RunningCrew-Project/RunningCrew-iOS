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

    weak var delegate: MyPageViewControllerDelegate?
    private var myPageView: MyPageView!
    private var viewControllers: [UIViewController]
    
    init(viewControllers: [UIViewController]) {
        self.viewControllers = viewControllers
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
        super.viewDidLoad()
        setNavigationBar()
        didSelect(indexNum: 0)
        myPageView.customTabBar.delegate = self
    }
    
    override func bind() {
        
        
        myPageView.profileTitle.rx.tapGesture().when(.recognized)
            .bind { [weak self] _ in
                if LogInManager.shared.isLogIn() == false {
                    self?.delegate?.showLogInView()
                }
            }
            .disposed(by: disposeBag)
        
        myPageView.profileChagneButton.rx.tap.asDriver()
            .drive { [weak self] _ in self?.delegate?.showProfileChangeView() }
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
}

extension MyPageViewController: CustomTabBarDelegate {
    func didSelect(indexNum: Int) {
        if LogInManager.shared.isLogIn() == false {
            myPageView.pageView.subviews.forEach { view in
                view.isHidden = true
            }
            myPageView.needLogInLabel.isHidden = false
            return
        } else {
            myPageView.needLogInLabel.isHidden = true
        }
        
        let isContainView = myPageView.pageView.subviews.contains(where: {$0.isEqual(viewControllers[indexNum].view)})
        
        if isContainView == false {
            myPageView.pageView.addSubview(viewControllers[indexNum].view)
        }
        
        myPageView.pageView.subviews.forEach { view in
            view.isHidden = viewControllers[indexNum].view != view ? true : false
        }
    }
}
