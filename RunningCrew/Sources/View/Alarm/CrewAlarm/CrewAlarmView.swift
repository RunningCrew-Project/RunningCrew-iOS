//
//  CrewAlarmView.swift
//  RunningCrew
//
//  Created by 김기훈 on 2023/08/09.
//

import UIKit
import SnapKit

final class CrewAlarmView: BaseView {
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.register(UINib(nibName: "CrewAlarmViewCell", bundle: nil), forCellWithReuseIdentifier: CrewAlarmViewCell.identifier)
        return collectionView
    }()
    
    override func addViews() {
        self.addSubview(collectionView)
    }
    
    override func setConstraint() {
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
