//
//  MyPageViewController.swift
//  RunningCrew
//
//  Created by JunHwan Kim on 2023/02/13.
//

import UIKit
import RxSwift

protocol MyPageViewControllerDelegate: AnyObject {
    func showSettingView()
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
        myPageView.pageView.addSubview(viewControllers[0].view)
        myPageView.customTabBar.delegate = self
    }
    
    override func bind() {
        
        
        
        
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
        
        let isContainView = myPageView.pageView.subviews.contains(where: {$0.isEqual(viewControllers[indexNum].view)})
        
        if isContainView == false {
            myPageView.pageView.addSubview(viewControllers[indexNum].view)
        }
        
        myPageView.pageView.subviews.forEach { view in
            view.isHidden = viewControllers[indexNum].view != view ? true : false
        }
    }
}
