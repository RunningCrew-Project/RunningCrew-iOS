//
//  BaseViewModelType.swift
//  RunningCrew
//
//  Created by 김기훈 on 2023/07/02.
//

import RxSwift

protocol BaseViewModelType {
    associatedtype Input
    associatedtype Output
    
    var disposeBag: DisposeBag { get set }
    
    func transform(input: Input) -> Output
}
