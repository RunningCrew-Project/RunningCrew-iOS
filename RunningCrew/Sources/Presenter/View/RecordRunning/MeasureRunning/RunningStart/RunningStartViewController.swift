//
//  MeasureRunningViewController.swift
//  RunningCrew
//
//  Created by JunHwan Kim on 2023/02/21.
//

import UIKit
import NMapsMap
import RxCocoa
import RxSwift
import RxGesture

protocol RunningStartViewControllerDelegate: AnyObject {
    func showGoalSettingView(viewModel: RunningStartViewModel)
    func showRecordView()
}

class RunningStartViewController: BaseViewController {
    
    weak var delegate: RunningStartViewControllerDelegate?
    
    let viewModel: RunningStartViewModel
    
    init(viewModel: RunningStartViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        startButton.clipsToBounds = true
        startButton.layer.cornerRadius = startButton.frame.height / 2
    }
    
    //MARK: - UI Properties
    
    lazy var mapView: NMFNaverMapView = {
       let mapView = NMFNaverMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.mapView.zoomLevel = 16
        mapView.showLocationButton = true
        mapView.showZoomControls = false
        
        return mapView
    }()
    
    lazy var startButtonStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 41.0
        
        return stackView
    }()
    
    lazy var goalSettingStackView: GoalSettingStackView = {
        let goalSettingStackView = GoalSettingStackView(goalType: viewModel.goalType)
        goalSettingStackView.translatesAutoresizingMaskIntoConstraints = false
        goalSettingStackView.goalSettingLabelStackView.isUserInteractionEnabled = true
        goalSettingStackView.beforeButton.isHidden = true
        
        return goalSettingStackView
    }()
    
    lazy var startButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .tabBarSelect
        button.setTitle("시작", for: .normal)
        button.titleLabel?.font = UIFont(name: "NotoSansKR-Bold", size: 24.0)
        
        return button
    }()
    
    deinit {
        print("deinit runningStart view")
    }
    
    override func setView() {
        self.view.backgroundColor = .systemBackground
    }
    
    override func setAddView() {
        view.addSubview(mapView)
        view.addSubview(startButtonStackView)
        startButtonStackView.addArrangedSubview(goalSettingStackView)
        startButtonStackView.addArrangedSubview(startButton)
    }
    
    override func setConstraint() {
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.45)
        ])

        NSLayoutConstraint.activate([
            startButtonStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startButtonStackView.topAnchor.constraint(equalTo: mapView.bottomAnchor, constant: view.frame.height * (CGFloat(71) / CGFloat(1624))),
            startButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: CGFloat(180) / CGFloat(1624)),
            startButton.widthAnchor.constraint(equalTo: startButton.heightAnchor)
        ])
    }
    
    //MARK: - Method
    
    override func bind() {
        let input = RunningStartViewModel.Input(
            nextButtonDidTap: goalSettingStackView.nextButton.rx.tap.asObservable(),
            beforeButtonDidTap: goalSettingStackView.beforeButton.rx.tap.asObservable(),
            navigationRightButtonDidTap: nil)
        
        let output = viewModel.transform(input: input)
        
        output.goalText
            .drive(goalSettingStackView.goalSettingLabelStackView.destinationLabel.rx.text)
            .disposed(by: disposeBag)
        
        goalSettingStackView.goalSettingLabelStackView.destinationLabel.rx.tapGesture()
            .when(.recognized)
            .bind { _ in self.delegate?.showGoalSettingView(viewModel: self.viewModel) }
            .disposed(by: disposeBag)
    
        startButton.rx.tap
            .bind { self.delegate?.showRecordView() }
            .disposed(by: disposeBag)
    }
}
