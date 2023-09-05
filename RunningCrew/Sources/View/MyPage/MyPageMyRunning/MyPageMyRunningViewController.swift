//
//  MyPageMyRunningViewController.swift
//  RunningCrew
//
//  Created by Dongwan Ryoo on 2023/04/07.
//

import UIKit
import SnapKit

final class MyPageMyRunningViewController: BaseViewController {
    
    private var myPageMyRunningView: MyPageMyRunningView!
    private let viewModel: MyPageMyRunningViewModel
    
    private var runningRecordDataSource: UICollectionViewDiffableDataSource<Int, AllRunningRecordContent>!
    
    init(viewModel: MyPageMyRunningViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.myPageMyRunningView = MyPageMyRunningView()
        self.view = myPageMyRunningView
        
        runningRecordDataSource = UICollectionViewDiffableDataSource(collectionView: myPageMyRunningView.collectionView) { collectionView, indexPath, record in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyPageMyRunningViewCell.identifier, for: indexPath) as? MyPageMyRunningViewCell else { return MyPageMyRunningViewCell() }
            cell.configure(runningRecord: record)
            cell.setUpUI()
            return cell
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func bind() {
        let input = MyPageMyRunningViewModel.Input()
        let output = viewModel.transform(input: input)
        
        output.allRunningRecord
            .withUnretained(self)
            .subscribe(onNext: { (owner, records) in
                var updatedSnapshot = NSDiffableDataSourceSnapshot<Int, AllRunningRecordContent>()
                updatedSnapshot.appendSections([0])
                updatedSnapshot.appendItems(records, toSection: 0)
                owner.runningRecordDataSource.apply(updatedSnapshot, animatingDifferences: true)
            })
            .disposed(by: disposeBag)
    }
}
