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
    func showCrewSearchView()
    func showCrewJoinView()
}

final class CrewViewController: BaseViewController {
    
    weak var coordinator: CrewViewControllerDelegate?
    
    private let viewModel: CrewViewModel
    private var crewView: CrewView!
    
    private var myCrewDataSource: UICollectionViewDiffableDataSource<Int, Crew>!
    private var recommendCrewDataSource: UICollectionViewDiffableDataSource<Int, GuRecommendCrew>!
    
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
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setMyCrewDataSource()
        setRecommendCrewDataSource()
    }
    
    override func bind() {
        let input = CrewViewModel.Input(
            leftBarButtonItemDidTap: navigationItem.leftBarButtonItem?.rx.tap.asObservable(),
            rightBarButtonItemDidTap: navigationItem.rightBarButtonItem?.rx.tap.asObservable())
        let output = viewModel.transform(input: input)
        
        output.isLogIn
            .subscribe(onNext: { [weak self] isLogIn in
                self?.crewView.myCrewTitleLabel.isHidden = !isLogIn
                self?.crewView.myCrewCollectionView.isHidden = !isLogIn
            })
            .disposed(by: disposeBag)
        
        output.myCrew
            .withUnretained(self)
            .subscribe(onNext: { (owner, crew) in
                var updateSnapshot = NSDiffableDataSourceSnapshot<Int, Crew>()
                updateSnapshot.appendSections([0])
                updateSnapshot.appendItems(crew, toSection: 0)
                owner.myCrewDataSource.apply(updateSnapshot)
            })
            .disposed(by: disposeBag)
        
        output.recommendCrew
            .withUnretained(self)
            .subscribe(onNext: { (owner, recommendCrew) in
                var listSnapshot = NSDiffableDataSourceSnapshot<Int, GuRecommendCrew>()
                listSnapshot.appendSections([0])
                listSnapshot.appendItems(recommendCrew, toSection: 0)
                owner.recommendCrewDataSource.apply(listSnapshot)
            })
            .disposed(by: disposeBag)
        
        output.address
            .withUnretained(self)
            .bind { (owner, address) in
                guard address != "현 위치를 찾을 수 없습니다." else { return }
                let gu = address.components(separatedBy: " ")[...1].joined(separator: " ")
                owner.crewView.recommendCrewLabel.text = gu + " 추천 크루"
            }
            .disposed(by: disposeBag)
        
        output.generateCrewResult?
            .bind { [weak self] _ in self?.coordinator?.showCrewGenerateView() }
            .disposed(by: disposeBag)
        
        output.searchCrewResult?
            .bind { [weak self] _ in self?.coordinator?.showCrewSearchView() }
            .disposed(by: disposeBag)
    }
}

extension CrewViewController {
    private func setMyCrewDataSource() {
        myCrewDataSource = UICollectionViewDiffableDataSource(collectionView: crewView.myCrewCollectionView) { collectionView, indexPath, crew in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyCrewCollectionViewCell.identifier, for: indexPath) as? MyCrewCollectionViewCell else {
                return MyCrewCollectionViewCell()
            }
            cell.configure(crew: crew)
            return cell
        }
    }
    
    private func setRecommendCrewDataSource() {
        recommendCrewDataSource = UICollectionViewDiffableDataSource(collectionView: crewView.recommendCrewCollectionView) { collectionView, indexPath, recommendCrew in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendCrewCollectionViewCell.identifier, for: indexPath) as? RecommendCrewCollectionViewCell else {
                return RecommendCrewCollectionViewCell()
            }
            cell.configure(recommendCrew: recommendCrew)
            return cell
        }
    }
}

extension CrewViewController {
}
