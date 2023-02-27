//
//  MeasureRunningViewController.swift
//  RunningCrew
//
//  Created by JunHwan Kim on 2023/02/21.
//

import UIKit
import NMapsMap
import RxCocoa

class RunningStartViewController: UIViewController {
    
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
        
        return  stackView
    }()
    
    lazy var destinationStackView: GoalSettingStackView = {
       let destinationStackView = GoalSettingStackView()
        destinationStackView.translatesAutoresizingMaskIntoConstraints = false
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapDestinationLabel))
        destinationStackView.goalSettingLabelStackView.isUserInteractionEnabled = true
        destinationStackView.goalSettingLabelStackView.addGestureRecognizer(tapGestureRecognizer)
        
        return destinationStackView
    }()
    
    lazy var underButtonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        
        return stackView
    }()
    
    lazy var startButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .tabBarSelect
        button.setTitle("시작", for: .normal)
        button.addTarget(self, action: #selector(tapStartButton), for: .touchUpInside)
        
        button.titleLabel?.font = UIFont(name: "NotoSansKR-Bold", size: 24.0)
        
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.title = "개인러닝"
        setMapView()
        setStartButtonStackView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        startButton.clipsToBounds = true
        startButton.layer.cornerRadius = startButton.frame.height / 2
    }
    
    //MARK: - UI Settings
    
    func setMapView() {
        view.addSubview(mapView)
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.45)
        ])
    }
    
    func setStartButtonStackView() {
        view.addSubview(startButtonStackView)
        startButtonStackView.addArrangedSubview(destinationStackView)
        startButtonStackView.addArrangedSubview(startButton)
        
        NSLayoutConstraint.activate([
            startButtonStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startButtonStackView.topAnchor.constraint(equalTo: mapView.bottomAnchor, constant: view.frame.height * (CGFloat(71) / CGFloat(1624))),
            startButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: CGFloat(180) / CGFloat(1624)),
            startButton.widthAnchor.constraint(equalTo: startButton.heightAnchor)
            
        ])
    }
    
    @objc func tapDestinationLabel() {
        let navigationVC = UINavigationController()
        navigationVC.modalPresentationStyle = .overFullScreen
        navigationVC.navigationBar.titleTextAttributes = [.font: UIFont(name: "NotoSansKR-Medium", size: 20) ?? .boldSystemFont(ofSize: 20)]
        let vc = GoalSettingViewController()
        navigationVC.pushViewController(vc, animated: false)
        present(navigationVC, animated: false)
    }
    
    @objc func tapStartButton() {
        print("tap start")
    }
    
    deinit {
        print("deinit measure view")
    }
    
}
