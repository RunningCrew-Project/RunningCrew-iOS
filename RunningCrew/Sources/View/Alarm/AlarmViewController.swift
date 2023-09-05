//
//  AlarmViewController.swift
//  RunningCrew
//
//  Created by JunHwan Kim on 2023/02/13.
//

import UIKit

final class AlarmViewController: BaseViewController {
    
    private var alarmView: AlarmView!
    private var viewModel: AlarmViewModel
    private var viewControllers: [UIViewController]
    
    init(viewControllers: [UIViewController], viewModel: AlarmViewModel) {
        self.viewControllers = viewControllers
        self.viewModel = viewModel
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
        
        self.alarmView = AlarmView(items: items)
        self.view = alarmView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        alarmView.customTabBar.delegate = self
        setNavigationBar()
    }
    
    override func bind() {
        let input = AlarmViewModel.Input()
        let output = viewModel.transform(input: input)
        
        output.isLogIn
            .subscribe(onNext: { [weak self] isLogIn in
                self?.showNeedLogInView(isLogIn: isLogIn)
            })
            .disposed(by: disposeBag)
    }
}

extension AlarmViewController {
    private func setNavigationBar() {
        navigationController?.navigationBar.topItem?.title = "알림"
        navigationController?.navigationBar.titleTextAttributes = [.font: UIFont.boldSystemFont(ofSize: 20)]
    }
    
    private func showNeedLogInView(isLogIn: Bool) {
        self.alarmView.needLogInView.isHidden = isLogIn
        self.didSelect(indexNum: 0)
    }
}

extension AlarmViewController: CustomTabBarDelegate {
    func didSelect(indexNum: Int) {
        if alarmView.needLogInView.isHidden == false {
            return
        }
        
        if let lastView = alarmView.pageView.subviews.last, lastView != alarmView.needLogInView {
            lastView.removeFromSuperview()
        }
        alarmView.pageView.addSubview(viewControllers[indexNum].view)
    }
}
