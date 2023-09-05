//
//  ViewController.swift
//  RunningCrew
//
//  Created by Dongwan Ryoo on 2023/07/06.
//

import UIKit
import RxSwift
import RxCocoa

final class ProfileChangeViewController: BaseViewController {
    
    private var profileChangeView: ProfileChangeView!
    private var viewModel: ProfileChangeViewModel
    
    init(viewModel: ProfileChangeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.profileChangeView = ProfileChangeView()
        self.view = profileChangeView
        self.navigationItem.title = "프로필 편집"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func bind() {
        let input = ProfileChangeViewModel.Input()
        let output = viewModel.transform(input: input)
        
        output.user
            .bind { [weak self] user in
                guard let user = user else { return }
                self?.profileChangeView.configure(data: user)
            }
            .disposed(by: disposeBag)
    }
}
