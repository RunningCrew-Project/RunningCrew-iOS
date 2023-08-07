//
//  CrewRunningView.swift
//  RunningCrew
//
//  Created by 김기훈 on 2023/08/07.
//

import UIKit
import SnapKit

final class CrewRunningView: BaseView {
    
    lazy var advertisementContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray4
        
        return view
    }()
    
    lazy var runningScheduleCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.register(CrewRunningScheduleCell.self, forCellWithReuseIdentifier: CrewRunningScheduleCell.identifier)
        collectionView.delegate = self
        return collectionView
    }()
    
    override func addViews() {
        self.addSubview(advertisementContainer)
        self.addSubview(runningScheduleCollectionView)
    }
    
    override func setConstraint() {
        advertisementContainer.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(self.safeAreaLayoutGuide)
            $0.height.equalToSuperview().multipliedBy(CGFloat(Double(120) / Double(1624)))
        }
        
        runningScheduleCollectionView.snp.makeConstraints {
            $0.top.equalTo(advertisementContainer.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}

extension CrewRunningView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.width * (344.0 / 744.0))
    }
}

extension CrewRunningView: UICollectionViewDelegate {
    
}
