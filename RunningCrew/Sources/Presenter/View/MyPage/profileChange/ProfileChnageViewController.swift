//
//  ViewController.swift
//  RunningCrew
//
//  Created by Dongwan Ryoo on 2023/07/06.
//

import UIKit

final class ProfileChangeViewController: UIViewController {
    
    let profileChnageView = ProfileChnageView()
    
    override func loadView() {
        view = profileChnageView
    }

    override func viewDidLoad() {
//        self.view.addSubview(profileChnageView)
        super.viewDidLoad()
        setNavigationBar()
        self.view.backgroundColor = .white
    }
    
    func setNavigationBar() {
        self.navigationItem.title = "프로필 편집"
        self.navigationItem.backBarButtonItem?.isEnabled = false
    }
    
    
   

}
