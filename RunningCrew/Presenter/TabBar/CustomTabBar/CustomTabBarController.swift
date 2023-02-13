//
//  CustomTabBarController.swift
//  RunningCrew
//
//  Created by JunHwan Kim on 2023/02/13.
//

import UIKit

class CustomTabBarController: UITabBarController {
    
    var items: [UIViewController]?

    override func viewDidLoad() {
        super.viewDidLoad()
        setTabBarItemTextSize()
    }
    
    func configureTabBarController() {
        self.setViewControllers(items, animated: false)
        tabBar.backgroundColor = .white
        tabBar.unselectedItemTintColor = .black
        tabBar.tintColor = .tabBarSelect
        tabBar.layer.borderColor = UIColor.tabBarBorder?.cgColor
        tabBar.layer.borderWidth = 1
        tabBar.clipsToBounds = true
    }
    
    func setTabBarItemTextSize() {
//        let customFont = UIFont(name: "NotoSansKR-Medium", size: 8)
//        let attributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: customFont]
//        UITabBarItem.appearance().setTitleTextAttributes(attributes, for: .normal)
        UIFont.familyNames.sorted().forEach { familyName in
            print("*** \(familyName) ***")
            UIFont.fontNames(forFamilyName: familyName).forEach { fontName in
                print("\(fontName)")
            }
            print("---------------------")
        }
    }

}
