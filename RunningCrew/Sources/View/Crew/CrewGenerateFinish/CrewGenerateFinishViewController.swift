//
//  CrewGenerateFinishViewController.swift
//  RunningCrew
//
//  Created by Kim TaeSoo on 2023/05/05.
//

import UIKit
import RxCocoa
import RxSwift
// import YPImagePicker

class CrewGenerateFinishViewController: UIViewController {
    let crewGenerateFinishView = CrewGenerateFinishView()
    let disposeBag = DisposeBag()
    
    override func loadView() {
        view = crewGenerateFinishView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    func bind() {
        crewGenerateFinishView.closeButton.rx.tap
            .withUnretained(self)
            .bind { vc, _ in
                vc.dismiss(animated: true)
            }.disposed(by: disposeBag)
        crewGenerateFinishView.showCrewButton.rx.tap
            .withUnretained(self)
            .bind { vc, _ in
                vc.dismiss(animated: true)
                // vc.setPicker()
            }.disposed(by: disposeBag)
    }
}
