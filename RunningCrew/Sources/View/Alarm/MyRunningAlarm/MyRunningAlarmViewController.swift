//
//  MyRunningViewController.swift
//  RunningCrew
//
//  Created by JunHwan Kim on 2023/02/16.
//

import UIKit

final class MyRunningAlarmViewController: BaseViewController {
    
    private var myRunningAlarmView: MyRunningAlarmView!
    private let viewModel: MyRunningAlarmViewModel
    private var noticeDataSource: UICollectionViewDiffableDataSource<Int, RunningNotice>!
    
    init(viewModel: MyRunningAlarmViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.myRunningAlarmView = MyRunningAlarmView()
        self.view = myRunningAlarmView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        noticeDataSource = UICollectionViewDiffableDataSource(collectionView: myRunningAlarmView.collectionView) { collectionView, indexPath, notice in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyRunningCollectionViewCell.identifier, for: indexPath) as? MyRunningCollectionViewCell else {
                return MyRunningCollectionViewCell()
            }
            cell.configure(data: notice)
            return cell
        }
    }
    
    override func bind() {
        let input = MyRunningAlarmViewModel.Input()
        let output = viewModel.transform(input: input)
        
        output.runningNotices
            .subscribe(onNext: { runningNotice in
                print(runningNotice)
            })
            .disposed(by: disposeBag)
    }
}
