//
//  RecordRunningViewController.swift
//  RunningCrew
//
//  Created by JunHwan Kim on 2023/02/12.
//

import UIKit
import RxSwift
import RxCocoa

protocol RecordRunningViewControllerDelegate: AnyObject {
    func showIndividualView()
    func showCrewView()
}

final class RecordRunningViewController: BaseViewController {
 
    weak var coordinator: RecordRunningViewControllerDelegate?
    
    private let viewModel: RecordRunningViewModel
    private var recordRunningView: RecordRunningView!
    
    init(viewModel: RecordRunningViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.recordRunningView = RecordRunningView()
        self.view = recordRunningView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavigationBarAndTabBar()
    }
    
    override func bind() {
        let input = RecordRunningViewModel.Input(locationButtonDidTap:
                                                    recordRunningView.locationButton.rx.tap.asObservable(),
                                                 individualRunningButtonDidTap: recordRunningView.individualRunningButton.rx.tap.asObservable(),
                                                 crewRunningButtonDidTap: recordRunningView.crewRunningButton.rx.tap.asObservable()
        )
        let output = viewModel.transform(input: input)
        
        output.currentAddress
            .observe(on: MainScheduler.instance)
            .bind { [weak self] location in
                self?.recordRunningView.locationLabel.setTitle(location, for: .normal)
            }
            .disposed(by: disposeBag)
        
        output.needAction
            .bind { [weak self] type in
                switch type {
                case .locationButton: return
                case .individualRunning:
                    self?.navigationController?.setNavigationBarHidden(false, animated: false)
                    self?.coordinator?.showIndividualView()
                case .crewRunning:
                    self?.navigationController?.setNavigationBarHidden(false, animated: false)
                    self?.coordinator?.showCrewView()
                case .needAuthorizationAlert:
                    self?.showMoveSettingAlert()
                case .needLogIn:
                    self?.showAlert(title: "비로그인", message: "로그인해야 이용할 수 있습니다.", actions: [UIAlertAction(title: "확인", style: .cancel)])
                }
            }
            .disposed(by: disposeBag)
    }
}

extension RecordRunningViewController {
    private func setupNavigationBarAndTabBar() {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.navigationController?.navigationBar.layoutMargins = UIEdgeInsets(top: 0, left: 40, bottom: 0, right: 0)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    private func showMoveSettingAlert() {
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        let confirmAction = UIAlertAction(title: "예", style: .default) {_ in
            guard let url = URL(string: UIApplication.openSettingsURLString) else { return }

            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            }
        }
        
        showAlert(title: "위치권한", message: "러닝거리 측정을 위해 위치 권한이 필요합니다. 설정으로 이동하시겠습니까?", actions: [cancelAction, confirmAction])
    }
}
