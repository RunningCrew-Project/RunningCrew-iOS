//
//  SignUpViewController.swift
//  RunningCrew
//
//  Created by 김기훈 on 2023/07/28.
//

import Foundation

final class SignUpViewController: BaseViewController {
    
    private var signUpView: SignUpView!
    private var viewModel: SignUpViewModel
    
    init(viewModel: SignUpViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.signUpView = SignUpView()
        self.view = signUpView
    }
    
    override func bind() {
        let input = SignUpViewModel.Input()
        let output = viewModel.transform(input: input)
    }
}
