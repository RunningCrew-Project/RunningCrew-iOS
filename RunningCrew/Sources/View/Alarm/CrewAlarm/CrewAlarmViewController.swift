//
//  CrewAlarmViewController.swift
//  RunningCrew
//
//  Created by JunHwan Kim on 2023/02/16.
//

import UIKit

final class CrewAlarmViewController: BaseViewController {

    private var crewAlarmView: CrewAlarmView!
    private let viewModel: CrewAlarmViewModel
    private var notificationDataSource: UICollectionViewDiffableDataSource<Int, NotificationContent>!
    
    init(viewModel: CrewAlarmViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.crewAlarmView = CrewAlarmView()
        self.view = crewAlarmView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        notificationDataSource = UICollectionViewDiffableDataSource(collectionView: crewAlarmView.collectionView) { collectionView, indexPath, notification in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CrewAlarmViewCell.identifier, for: indexPath) as? CrewAlarmViewCell else {
                return CrewAlarmViewCell()
            }
            cell.configure(content: notification)
            return cell
        }
    }
    
    override func bind() {
        let input = CrewAlarmViewModel.Input()
        let output = viewModel.transform(input: input)
        
        output.notifications
            .withUnretained(self)
            .subscribe(onNext: { (owner, notification) in
                var listSnapshot = NSDiffableDataSourceSnapshot<Int, NotificationContent>()
                listSnapshot.appendSections([0])
                listSnapshot.appendItems(notification.content, toSection: 0)
                owner.notificationDataSource.apply(listSnapshot)
            })
            .disposed(by: disposeBag)
    }
}
