//
//  CrewViewController.swift
//  RunningCrew
//
//  Created by JunHwan Kim on 2023/02/13.
//

import UIKit
import RxCocoa
import RxSwift

class CrewViewController: UIViewController {
    let crewView = CrewView()
    var coordinator: CrewCoordinator?

    var memberDataSource: UICollectionViewDiffableDataSource<Int, String>!
    var memberSnapshot = NSDiffableDataSourceSnapshot<Int, String>()
    
    var listDataSource: UICollectionViewDiffableDataSource<Int, String>!
    var listSnapshot = NSDiffableDataSourceSnapshot<Int, String>()
    private var disposebag = DisposeBag()
    override func loadView() {
        view = crewView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setMemberDataSource()
        setCrewListDataSource()
        setNavigationController()
        
    }
    func setNavigationController() {
        let plusButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(showJoinView))
        navigationItem.leftBarButtonItem = plusButton
        
    }
    
    @objc func showGenerateView() {
        let vc = CrewGenerateViewController()
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        nav.isNavigationBarHidden = true
        self.present(nav, animated: true)
    }
    
    @objc func showJoinView() {
        let vc = CrewJoinViewController()
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        
        self.present(nav, animated: true)
    }
    
    // Member
    func setMemberDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<CrewMemberCollectionViewCell, String> { cell, indexPath, itemIdentifier in
            
        }
        memberDataSource = UICollectionViewDiffableDataSource(collectionView: crewView.myCrewCollectionView) { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            return cell
        }
        let tempItem = ["0","1","2","3","4","5","6","7","8","9", "10","11","12","13","14","15","16","17","18","19"]
        
        
        memberSnapshot.appendSections([0, 1])
        memberSnapshot.appendItems(tempItem, toSection: 0)
//        memberSnapshot.appendItems(["10","11","12","13","14","15","16","17","18","19"], toSection: 1)
        memberDataSource.apply(memberSnapshot)
    }
    // Recommend
    func setCrewListDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<CrewListCollectionViewCell, String> { cell, indexPath, itemIdentifier in
            
        }
        listDataSource = UICollectionViewDiffableDataSource(collectionView: crewView.recommandCrewCollectionView) { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            
            return cell
        }
        listSnapshot.appendSections([0])
        listSnapshot.appendItems(["1","2","3","4","5","6","7","8","9"], toSection: 0)
        listDataSource.apply(listSnapshot)
    }
    
}
