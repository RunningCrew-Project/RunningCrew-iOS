//
//  CrewViewController.swift
//  RunningCrew
//
//  Created by JunHwan Kim on 2023/02/13.
//

import UIKit
import RxCocoa
import RxSwift

protocol CrewViewControllerDelegate: AnyObject {
    func showCrewGenerateView()
    func showCrewJoinView()
}

final class CrewViewController: BaseViewController {
    
    weak var coordinator: CrewViewControllerDelegate?
    
    private let viewModel: CrewViewModel
    private var crewView: CrewView!
    
    var myCrewDataSource: UICollectionViewDiffableDataSource<Int, String>!
    var recommendCrewDataSource: UICollectionViewDiffableDataSource<Int, String>!
    
    init(viewModel: CrewViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.crewView = CrewView()
        self.view = crewView
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setMyCrewDataSource()
        setRecommendCrewDataSource()
    }
    
    override func bind() {
        
        navigationItem.leftBarButtonItem?.rx.tap
            .bind { [weak self] in self?.coordinator?.showCrewGenerateView() }
            .disposed(by: disposeBag)
    }
    
    func setMyCrewDataSource() {
        myCrewDataSource = UICollectionViewDiffableDataSource(collectionView: crewView.myCrewCollectionView) { collectionView, indexPath, itemIdentifier in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyCrewCollectionViewCell.identifier, for: indexPath) as? MyCrewCollectionViewCell else {
                return MyCrewCollectionViewCell()
            }
            return cell
        }
        let tempItem = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19"]
        
        var updateSnapshot = NSDiffableDataSourceSnapshot<Int, String>()
        updateSnapshot.appendSections([0, 1])
        updateSnapshot.appendItems(tempItem, toSection: 0)
        myCrewDataSource.apply(updateSnapshot)
    }
    
    func setRecommendCrewDataSource() {
        recommendCrewDataSource = UICollectionViewDiffableDataSource(collectionView: crewView.recommandCrewCollectionView) { collectionView, indexPath, itemIdentifier in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendCrewCollectionViewCell.identifier, for: indexPath) as? RecommendCrewCollectionViewCell else {
                return RecommendCrewCollectionViewCell()
            }
            return cell
        }
        
        var listSnapshot = NSDiffableDataSourceSnapshot<Int, String>()
        listSnapshot.appendSections([0])
        listSnapshot.appendItems(["1", "2", "3", "4", "5", "6", "7", "8", "9"], toSection: 0)
        recommendCrewDataSource.apply(listSnapshot)
    }
}
