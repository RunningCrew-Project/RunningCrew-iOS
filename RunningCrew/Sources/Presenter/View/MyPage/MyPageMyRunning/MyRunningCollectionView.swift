//
//  MyRunningCollectionView.swift
//  RunningCrew
//
//  Created by Dongwan Ryoo on 2023/05/05.
//

import UIKit

class MyRunningCollectionView:UIView {
    
    lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: CGRect(), collectionViewLayout: flowLayout)
        
        return collectionView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(collectionView)
        setCollectionVeiw()
        collectionViewConstraint()
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCollectionVeiw() {
        collectionView.backgroundColor = .white
        collectionView.register(MyPageMyRunningCollectionViewCell.self, forCellWithReuseIdentifier: MyPageMyRunningCollectionViewCell.identifier)
        
    }
    
    func collectionViewConstraint() {
        collectionView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    
}


extension MyRunningCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // cell 클릭 시 액션 처리
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyPageMyRunningCollectionViewCell.identifier, for: indexPath) as? MyPageMyRunningCollectionViewCell else { return MyPageMyRunningCollectionViewCell() }
        
        return cell
    }
    
}

extension MyRunningCollectionView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.frame.inset(by: UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)).width
        let height = 125.0
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 15.0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(15.0)
    }
}





