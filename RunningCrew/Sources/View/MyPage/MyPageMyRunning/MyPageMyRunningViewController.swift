//
//  MyPageMyRunningViewController.swift
//  RunningCrew
//
//  Created by Dongwan Ryoo on 2023/04/07.
//

import UIKit
import SnapKit

final class MyPageMyRunningViewController: UIViewController {
    
    lazy var collectionView = MyRunningCollectionView()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.tabBarItem.title = "마이러닝"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCollectionView()
        collectionViewConstraint()
    }
    
    func setCollectionView() {
        view.addSubview(collectionView)
    }
    
    func collectionViewConstraint() {
        collectionView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
    }
}
