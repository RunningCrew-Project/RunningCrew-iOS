//
//  RecordRunningViewController.swift
//  RunningCrew
//
//  Created by JunHwan Kim on 2023/02/12.
//

import UIKit
import RxSwift
import SnapKit

protocol RecordRunningViewControllerDelegate: AnyObject {
    func showIndividualView()
    func showCrewView()
}

final class RecordRunningViewController: BaseViewController {
    
    weak var delegate: RecordRunningViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    lazy var advertisementContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray4
        
        return view
    }()
    
    lazy var locationButton: UIButton = {
        let button = LocationButton()
        
        return button
    }()
    
    lazy var discussionLabel: UILabel = {
        let label = UILabel()
        label.text = "러닝 기록하기"
        label.font = UIFont(name: "NotoSansKR-Bold", size: 24)
        
        return label
    }()
    
    lazy var individualRunningButton: UIButton = {
        let button = RunningButton()
        button.backgroundColor = .tabBarSelect
        button.setTitle("개인 러닝", for: .normal)
        button.discussionLabel.text = "혼자서도 잘 달릴수 있어요"
        button.setInset(height: view.frame.height)
        
        return button
    }()
    
    lazy var crewRunningButton: UIButton = {
        let button = RunningButton()
        button.backgroundColor = .darkGreen
        button.setTitle("크루 러닝", for: .normal)
        button.discussionLabel.text = "크루원들과 함께 힘찬 러닝"
        button.setInset(height: view.frame.height)

        return button
    }()
    
    lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = view.frame.height * (Double(14) / Double(1624))
        stackView.alignment = .leading
        
        return stackView
    }()
    
    lazy var labelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = view.frame.height * (Double(54) / Double(1624))
        stackView.axis = .vertical
        stackView.distribution = .fill
        
        return stackView
    }()
    
    lazy var runningButtonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = view.frame.height * (Double(48) / Double(1624))
        stackView.distribution = .fillEqually
        
        return stackView
    }()
    
    override func setView() {
        let leadTrailInset = self.view.frame.width * (Double(48) / Double(750))
        
        self.view.layoutMargins = UIEdgeInsets(top: 0, left: leadTrailInset, bottom: 0, right: leadTrailInset)
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.layoutMargins = UIEdgeInsets(top: 0, left: 40, bottom: 0, right: 0)
    }
    
    override func setAddView() {
        self.view.addSubview(advertisementContainer)
        self.view.addSubview(mainStackView)
        mainStackView.addArrangedSubview(locationButton)
        mainStackView.addArrangedSubview(labelStackView)
        labelStackView.addArrangedSubview(discussionLabel)
        labelStackView.addArrangedSubview(runningButtonStackView)
        runningButtonStackView.addArrangedSubview(individualRunningButton)
        runningButtonStackView.addArrangedSubview(crewRunningButton)
    }
    
    override func setConstraint() {
        advertisementContainer.snp.makeConstraints {
            $0.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            $0.height.equalTo(self.view.snp.height).multipliedBy(CGFloat(Double(120) / Double(1624)))
        }
        
        locationButton.snp.makeConstraints {
            $0.height.equalTo(CGFloat(23.0))
        }
        
        discussionLabel.snp.makeConstraints {
            $0.height.equalTo(CGFloat(35.0))
        }
        
        mainStackView.snp.makeConstraints {
            $0.leading.trailing.equalTo(self.view.layoutMarginsGuide)
            $0.top.equalTo(advertisementContainer.snp.bottom).offset(self.view.frame.height * (Double(18) / Double(1624)))
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(self.view.frame.height * -(Double(68) / Double(1624)))
        }
        
        labelStackView.snp.makeConstraints {
            $0.leading.trailing.equalTo(mainStackView)
        }
        
        runningButtonStackView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalTo(mainStackView)
        }
    }
    
    override func bind() {
        locationButton.rx.tap
            .bind {
                print("aaa")
                print($0)
            }
            .disposed(by: disposeBag)
        
        individualRunningButton.rx.tap
            .bind { [weak self] _ in
                self?.navigationController?.setNavigationBarHidden(false, animated: false)
                self?.delegate?.showIndividualView()
            }
            .disposed(by: disposeBag)
        
        crewRunningButton.rx.tap
            .bind { [weak self] _ in
                self?.navigationController?.setNavigationBarHidden(false, animated: false)
                self?.delegate?.showCrewView()
            }
            .disposed(by: disposeBag)
    }
}
