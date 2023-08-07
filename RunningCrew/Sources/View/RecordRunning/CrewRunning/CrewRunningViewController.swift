//
//  CrewRunningViewController.swift
//  RunningCrew
//
//  Created by 김기훈 on 2023/08/07.
//

import UIKit

protocol CrewRunningViewControllerDelegate: AnyObject {
    
}

final class CrewRunningViewController: BaseViewController {
    
    weak var coordinator: CrewRunningViewControllerDelegate?
    
    private let viewModel: CrewRunningViewModel
    private var crewRunningView: CrewRunningView!
    
    private var dataSource: UICollectionViewDiffableDataSource<Int, Crew>!
    
    init(viewModel: CrewRunningViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.crewRunningView = CrewRunningView()
        self.view = crewRunningView
    }
    
    override func viewDidLoad() {
        dataSource = UICollectionViewDiffableDataSource<Int, Crew>(collectionView: crewRunningView.runningScheduleCollectionView) { (collectionView, indexPath, crew) -> UICollectionViewCell? in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CrewRunningScheduleCell.identifier, for: indexPath) as? CrewRunningScheduleCell else { return CrewRunningScheduleCell() }
            cell.configure(crew: crew)
            
            return cell
        }
    }
    
    override func bind() {
        let input = CrewRunningViewModel.Input()
        let output = viewModel.transform(input: input)
        
    }
}
