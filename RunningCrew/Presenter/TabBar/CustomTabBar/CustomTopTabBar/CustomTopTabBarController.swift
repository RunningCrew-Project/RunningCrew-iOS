//
//  CustomTopTabBarController.swift
//  RunningCrew
//
//  Created by JunHwan Kim on 2023/02/15.
//

import UIKit

class CustomTopTabBarController: UIViewController {
    
    lazy var topTabBarMenu: CustomMenuBar = {
        let menuBar = CustomMenuBar()
        menuBar.translatesAutoresizingMaskIntoConstraints = false
        
        return menuBar
    }()
    
    lazy var pageView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray5
        return view
    }()
    
    private var items: [UIViewController] = []
    
    func setItems(items: [UIViewController]) {
        self.items = items
        var menuItemList: [MenuItem] = []
        items.forEach { vc in
            guard let vcTabBarTitle = vc.tabBarItem.title else { return }
            menuItemList.append(MenuItem(title: vcTabBarTitle, isSelect: false))
            pageView.addSubview(vc.view)
        }
        topTabBarMenu.setItems(items: menuItemList)
        pageView.subviews.forEach { view in
            view.isHidden = true
        }
    }
    
}

extension CustomTopTabBarController: CustomMenuBarDelegate {
    
    func didSelect(indexNum: Int) {
        pageView.subviews.forEach { view in
            view.isHidden = true
        }
        pageView.subviews[indexNum].isHidden = false
    }
}
