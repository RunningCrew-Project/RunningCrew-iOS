//
//  MyPageMyRunningView.swift
//  RunningCrew
//
//  Created by Dongwan Ryoo on 2023/05/05.
//

import UIKit
import SnapKit

final class MyPageMyRunningView: BaseView {
    
    lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(MyPageMyRunningViewCell.self, forCellWithReuseIdentifier: MyPageMyRunningViewCell.identifier)
        collectionView.delegate = self
        
        return collectionView
    }()
    
    override func addViews() {
        self.addSubview(collectionView)
    }
    
    override func setConstraint() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension MyPageMyRunningView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // cell 클릭 시 액션 처리
    }
}

extension MyPageMyRunningView: UICollectionViewDelegateFlowLayout {
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
