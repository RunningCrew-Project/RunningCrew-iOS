//
//  CrewGenerateViewController.swift
//  RunningCrew
//
//  Created by Kim TaeSoo on 2023/04/15.
//

import UIKit
import RxCocoa
import RxSwift

protocol CrewGenerateViewControllerDelegate: AnyObject {
    func closeCrewGenerateView()
}

final class CrewGenerateViewController: BaseViewController {
    
    weak var coordinator: CrewGenerateViewControllerDelegate?
    
    private let viewModel: CrewGenerateViewModel
    private var crewGenerateView: CrewGenerateView!
    
    init(viewModel: CrewGenerateViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.crewGenerateView = CrewGenerateView()
        self.view = crewGenerateView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    override func bind() {
        crewGenerateView.closeButton.rx.tap
            .bind { [weak self] _ in
                self?.coordinator?.closeCrewGenerateView()
            }.disposed(by: disposeBag)
        
//        crewGenerateView.generateButton.rx.tap
//            .withUnretained(self)
//            .bind { vc, _ in
//                vc.navigationController?.pushViewController(CrewGenerateFinishViewController(), animated: true)
//            }.disposed(by: disposeBag)
    }
}
