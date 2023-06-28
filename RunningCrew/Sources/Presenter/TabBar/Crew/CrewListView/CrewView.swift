//
//  CrewView.swift
//  RunningCrew
//
//  Created by Kim TaeSoo on 2023/04/05.
//

import UIKit
import SnapKit

class CrewView: BaseView {
    let adBanner: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        return view
    }()
    
    lazy var myCrewCollectionView = UICollectionView(frame: .zero, collectionViewLayout: createMyCrewLayout())
    let dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    lazy var recommandCrewCollectionView = UICollectionView(frame: .zero, collectionViewLayout: createRecommandCrewLayout())
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    override func setupUI() {
        [adBanner, myCrewCollectionView, dividerView, recommandCrewCollectionView].forEach { self.addSubview($0) }
        
    }
    override func makeConstraints() {
        adBanner.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(48)
        }
        myCrewCollectionView.snp.makeConstraints { make in
            make.top.equalTo(adBanner.snp.bottom)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(160)
        }
        dividerView.snp.makeConstraints { make in
            make.top.equalTo(myCrewCollectionView.snp.bottom)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(12)
        }
        recommandCrewCollectionView.snp.makeConstraints { make in
            make.top.equalTo(dividerView.snp.bottom)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
    
    func createMyCrewLayout() -> UICollectionViewLayout {
        UICollectionViewCompositionalLayout { section, env in
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(0.5)
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)

            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.2),
                heightDimension: .fractionalHeight(1.0)
            )
            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
            
            let section = NSCollectionLayoutSection(group: group)
            
            section.contentInsets = .init(top: 4, leading: 4, bottom: 4, trailing: 4)
            section.orthogonalScrollingBehavior = .groupPaging /// Set Scroll Direction
            return section
        }
    }
    
    func createRecommandCrewLayout() -> UICollectionViewLayout {
        UICollectionViewCompositionalLayout { section, env in
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(0.2)
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            )
            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
            
            let section = NSCollectionLayoutSection(group: group)
            
            section.orthogonalScrollingBehavior = .none /// Set Scroll Direction
            return section
        }
    }
   

}
