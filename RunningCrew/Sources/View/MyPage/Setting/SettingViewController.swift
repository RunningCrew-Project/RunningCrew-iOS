//
//  SettingViewController.swift
//  RunningCrew
//
//  Created by 김기훈 on 2023/08/10.
//

import Foundation
import RxSwift
import RxCocoa

protocol SettingViewControllerDelegate: AnyObject {
    func showMyPage()
}

final class SettingViewController: BaseViewController {
    
    weak var coordinator: SettingViewControllerDelegate?
    
    private var settingView: SettingView!
    private var viewModel: SettingViewModel
    
    init(viewModel: SettingViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.settingView = SettingView()
        self.view = settingView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func bind() {
        let input = SettingViewModel.Input(
            logOutButtonDidTap: settingView.bottomStackView.logOutButton.rx.tap.asObservable(),
            withDrawalDidTap: settingView.bottomStackView.withdrawalButton.rx.tap.asObservable())
        let output = viewModel.transform(input: input)
        
        output.isSuccessLogOut
            .asDriver(onErrorJustReturn: false)
            .drive { [weak self] result in
                result ? self?.coordinator?.showMyPage() : self?.settingView.showToast(message: "로그아웃에 실패했습니다.", position: .bottom)
            }
            .disposed(by: disposeBag)
        
        output.isSuccessWithDrawal
            .subscribe(onNext: { [weak self] result in
                result ? self?.coordinator?.showMyPage() : self?.settingView.showToast(message: "회원탈퇴에 실패했습니다.", position: .bottom)
            }, onError: { [weak self] _ in
                self?.settingView.showToast(message: "회원탈퇴에 실패했습니다.", position: .bottom)
            })
            .disposed(by: disposeBag)
        
        output.isLogIn
            .bind { [weak self] isLogIn in
                self?.settingView.bottomStackView.logOutStackView.isHidden = !isLogIn
                self?.settingView.bottomStackView.withdrawalStackView.isHidden = !isLogIn
            }
            .disposed(by: disposeBag)
    }
}
