//
//  BaseView.swift
//  RunningCrew
//
//  Created by Kim TaeSoo on 2023/04/05.
//

import UIKit
import RxSwift

class BaseView: UIView {
    
    var disposeBag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        makeConstraints()
        self.backgroundColor = .systemBackground
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() { }
    func makeConstraints() { }
}

