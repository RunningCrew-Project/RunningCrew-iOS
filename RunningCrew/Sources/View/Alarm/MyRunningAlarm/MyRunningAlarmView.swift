//
//  MyRunningAlarmView.swift
//  RunningCrew
//
//  Created by 김기훈 on 2023/08/10.
//

import UIKit
import SnapKit

final class MyRunningAlarmView: BaseView {
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.register(UINib(nibName: "MyRunningCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: MyRunningCollectionViewCell.identifier)
        return collectionView
    }()
    
    init() {
        super.init(frame: .zero)
        collectionView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func addViews() {
        self.addSubview(collectionView)
    }
    
    override func setConstraint() {
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension MyRunningAlarmView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyRunningCollectionViewCell.identifier, for: indexPath) as? MyRunningCollectionViewCell else { return MyRunningCollectionViewCell() }

        return cell
    }
}

extension MyRunningAlarmView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.frame.inset(by: UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)).width
        let height = 172.0
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 15.0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(15.0)
    }
}
