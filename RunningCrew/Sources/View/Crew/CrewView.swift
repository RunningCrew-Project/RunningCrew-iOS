//
//  CrewView.swift
//  RunningCrew
//
//  Created by Kim TaeSoo on 2023/04/05.
//

import UIKit
import SnapKit

final class CrewView: BaseView {
    
    lazy var adBanner: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        return view
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        
        return stackView
    }()
    
    lazy var myCrewTitleLabel = {
        let label = UILabel()
        label.text = "My 크루"
        return label
    }()
    
    lazy var myCrewCollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createMyCrewLayout())
        collectionView.register(MyCrewCollectionViewCell.self, forCellWithReuseIdentifier: MyCrewCollectionViewCell.identifier)
        return collectionView
    }()
    
    lazy var recommendCrewLabel = {
        let label = UILabel()
        label.text = "추천 크루"
        return label
    }()

    lazy var recommendCrewCollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createRecommandCrewLayout())
        collectionView.register(RecommendCrewCollectionViewCell.self, forCellWithReuseIdentifier: RecommendCrewCollectionViewCell.identifier)
        
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func addViews() {
        self.addSubview(adBanner)
        self.addSubview(stackView)
        stackView.addArrangedSubview(myCrewTitleLabel)
        stackView.addArrangedSubview(myCrewCollectionView)
        stackView.addArrangedSubview(recommendCrewLabel)
        stackView.addArrangedSubview(recommendCrewCollectionView)
    }
    
    override func setConstraint() {
        adBanner.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(48)
        }
        
        stackView.snp.makeConstraints {
            $0.top.equalTo(adBanner.snp.bottom)
            $0.horizontalEdges.equalToSuperview().inset(15)
        }
        
        myCrewTitleLabel.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(safeAreaLayoutGuide).multipliedBy(0.07)
        }
        
        myCrewCollectionView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(160)
        }
        
        recommendCrewLabel.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(safeAreaLayoutGuide).multipliedBy(0.07)
        }
        
        recommendCrewCollectionView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
    
    private func createMyCrewLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { section, _ in
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
    
    private func createRecommandCrewLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { section, _ in
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
