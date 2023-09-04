//
//  SignUpViewModel.swift
//  RunningCrew
//
//  Created by 김기훈 on 2023/07/28.
//

import Foundation
import RxSwift
import RxRelay

final class SignUpViewModel: BaseViewModelType {
    
    struct Input {
        let nameTextFieldDidChanged: Observable<String>
        let nickNameTextFieldDidChanged: Observable<String>
        let siAreaSelected: Observable<String>
        let guAreaSelected: Observable<String>
        let dongAreaSelected: Observable<String>
        let genderSelected: Observable<Int>
        let dateSelected: Observable<Date>
        let heightFieldDidChanged: Observable<String>
        let weightFieldDidChanged: Observable<String>
        let signUpButtonDidTap: Observable<Void>
    }
    
    struct Output {
        let nickNameValidateResult: Observable<String>
        let siData: Observable<SiDo>
        let guData: Observable<Gu>
        let dongData: Observable<Dong>
        let signUpResult: Observable<SignUpUser?>
    }
    
    private let userService: UserService
    private let locationService: LocationService
    private let logInService: LogInService
    private let accessToken: String
    private let refreshToken: String
    
    private var siArea: [Area] = []
    private var guArea: [Area] = []
    private var dongArea: [Area] = []
    
    private var name: String = ""
    private var nickName: String = ""
    private var si: String = ""
    private var gu: String = ""
    private var dongID: Int = 0
    private var gender: String = "MAN"
    private var birth: Date = Date()
    private var height: Int = 170
    private var weight: Int = 60
    
    private var nickNameValidateResult: PublishRelay<String> = PublishRelay()
    private var signUpResult: PublishRelay<SignUpUser?> = PublishRelay()
    
    var disposeBag = DisposeBag()
    
    init(logInService: LogInService, accessToken: String, refreshToken: String, locationService: LocationService, userService: UserService) {
        self.logInService = logInService
        self.accessToken = accessToken
        self.refreshToken = refreshToken
        self.locationService = locationService
        self.userService = userService
    }
    
    func transform(input: Input) -> Output {
        input.nameTextFieldDidChanged
            .bind { [weak self] name in
                self?.name = name
            }
            .disposed(by: disposeBag)
        
        input.nickNameTextFieldDidChanged
            .withUnretained(self)
            .debounce(.seconds(1), scheduler: MainScheduler.asyncInstance)
            .subscribe(onNext: { (owner, nickName) in
                owner.nickName = nickName

                if nickName.count < 2 || nickName.count > 8 {
                    owner.nickNameValidateResult.accept("닉네임은 2글자 이상 8글자 이하입니다.")
                    return
                }
                
                owner.userService.validateNickName(nickName: nickName)
                    .subscribe(onNext: { result in
                        if result {
                            owner.nickNameValidateResult.accept("중복된 닉네임입니다.")
                        } else {
                            owner.nickNameValidateResult.accept("")
                        }
                    })
                    .disposed(by: owner.disposeBag)
            })
            .disposed(by: disposeBag)
        
        let siData = locationService.getSi()
            .withUnretained(self)
            .map { (owner, si) -> SiDo in
                owner.siArea = si.areas
                return si
            }

        let guData = input.siAreaSelected
            .withUnretained(self)
            .flatMap { (owner, si) -> Observable<Gu> in
                guard let area = owner.siArea.filter({ $0.name == si }).first else {
                    return Observable.empty()
                }
                return owner.locationService.getGu(siID: area.id)
            }
            .map { [weak self] gu -> Gu in
                self?.guArea = gu.areas
                return gu
            }
            
        let dongData = input.guAreaSelected
            .withUnretained(self)
            .flatMap { (owner, gu) -> Observable<Dong> in
                guard let area = owner.guArea.filter({ $0.name == gu }).first else {
                    return Observable.empty()
                }
                return owner.locationService.getDong(guID: area.id)
            }
            .map { [weak self] dong -> Dong in
                self?.dongArea = dong.areas
                return dong
            }
        
        input.dongAreaSelected
            .subscribe(onNext: { [weak self] dong in
                guard let area = self?.dongArea.filter({ $0.name == dong }).first else {
                    return
                }
                self?.dongID = area.id
            })
            .disposed(by: disposeBag)

        input.genderSelected
            .bind { [weak self] gender in
                self?.gender = gender == 0 ? "MAN" : "WOMAN"
            }
            .disposed(by: disposeBag)
        
        input.dateSelected
            .subscribe(onNext: { [weak self] date in
                self?.birth = date
            })
            .disposed(by: disposeBag)

        input.heightFieldDidChanged
            .bind { [weak self] height in
                self?.height = Int(height) ?? 0
            }
            .disposed(by: disposeBag)

        input.weightFieldDidChanged
            .bind { [weak self] weight in
                self?.weight = Int(weight) ?? 0
            }
            .disposed(by: disposeBag)

        input.signUpButtonDidTap
            .withUnretained(self)
            .flatMap { (owner, _) -> Observable<SignUpUser> in
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                let dateString = dateFormatter.string(from: owner.birth)
                
                return owner.logInService.signUp(accessToken: owner.accessToken, refreshToken: owner.refreshToken, signUpData: SignUpUser(name: owner.name, nickname: owner.nickName, dongId: owner.dongID, birthday: dateString, sex: owner.gender, height: owner.height, weight: owner.weight))
            }
            .subscribe(onNext: { [weak self] signUpUser in
                print(signUpUser)
                self?.signUpResult.accept(signUpUser)
                print("성공")
            }, onError: { [weak self] error in
                print(error)
                self?.signUpResult.accept(nil)
            })
            .disposed(by: disposeBag)
            
        return Output(nickNameValidateResult: nickNameValidateResult.asObservable(),
                      siData: siData,
                      guData: guData,
                      dongData: dongData,
                      signUpResult: signUpResult.asObservable())
    }
}
