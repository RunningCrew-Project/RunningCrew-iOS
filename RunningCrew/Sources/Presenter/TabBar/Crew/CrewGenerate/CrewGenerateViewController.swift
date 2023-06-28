//
//  CrewGenerateViewController.swift
//  RunningCrew
//
//  Created by Kim TaeSoo on 2023/04/15.
//

import UIKit
import RxCocoa
import RxSwift

class CrewGenerateViewController: UIViewController {
    let crewGenerateView = CrewGenerateView()
    let disposBag: DisposeBag = DisposeBag()
    
    override func loadView() {
        view = crewGenerateView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    func bind() {
        crewGenerateView.closeButton.rx.tap
            .withUnretained(self)
            .bind { vc, _ in
                vc.navigationController?.topViewController?.dismiss(animated: true)
            }.disposed(by: disposBag)
        
        crewGenerateView.generateButton.rx.tap
            .withUnretained(self)
            .bind { vc, _ in
                vc.navigationController?.pushViewController(CrewGenerateFinishViewController(), animated: true)
            }.disposed(by: disposBag)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    @objc func keyboardWillAppear() {
        crewGenerateView.generateButton.snp.updateConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
        }
        crewGenerateView.generateButton.layer.cornerRadius = 0
    }

    @objc func keyboardWillDisappear() {
        crewGenerateView.generateButton.snp.updateConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
        crewGenerateView.generateButton.layer.cornerRadius = 8
    }
    
    
}
