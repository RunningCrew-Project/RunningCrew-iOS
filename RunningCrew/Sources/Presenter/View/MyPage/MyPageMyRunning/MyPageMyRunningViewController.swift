//
//  MyPageMyRunningViewController.swift
//  RunningCrew
//
//  Created by Dongwan Ryoo on 2023/04/07.
//

import UIKit
import SnapKit

class MyPageMyRunningViewController: UIViewController {
    //MARK: - UI ProPerties
    
    lazy var collectionView = MyRunningCollectionView()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.tabBarItem.title = "마이러닝"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Properties
    override func viewDidLoad() {
        super.viewDidLoad()
        setCollectionView()
        collectionViewConstraint()
    }
    
    //MARK: - Set UI
    
    func collectionViewConstraint() {
        collectionView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
            
        }
    }
    
   
    
    //MARK: - Define Method
    
    func setCollectionView() {
        view.addSubview(collectionView)
    }
    
}
    
