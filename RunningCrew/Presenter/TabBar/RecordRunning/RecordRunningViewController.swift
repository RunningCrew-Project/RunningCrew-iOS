//
//  RecordRunningViewController.swift
//  RunningCrew
//
//  Created by JunHwan Kim on 2023/02/12.
//

import UIKit

final class RecordRunningViewController: UIViewController {
    
    lazy var advertisementContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray4
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var locationButton: UIButton = {
        let button = LocationButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var discussionLabel: UILabel = {
        let label = UILabel()
        label.text = "러닝 기록하기"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 24)
        
        return label
    }()
    
    lazy var individualRunningButton: UIButton = {
        let button = RunningButton()
        button.backgroundColor = .tabBarSelect
        button.setTitle("개인 러닝", for: .normal)
        button.discussionLabel.text = "혼자서도 잘 달릴수 있어요"
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setInset(height: view.frame.height)
        
        return button
    }()
    
    lazy var crewRunningButton: UIButton = {
        let button = RunningButton()
        button.backgroundColor = .darkGreen
        button.setTitle("크루 러닝", for: .normal)
        button.discussionLabel.text = "크루원들과 함께 힘찬 러닝"
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setInset(height: view.frame.height)
        return button
    }()
    
    lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = view.frame.height * (Double(14) / Double(1624))
        stackView.alignment = .leading
        
        return stackView
    }()
    
    lazy var labelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = view.frame.height * (Double(54) / Double(1624))
        stackView.axis = .vertical
        
        return stackView
    }()
    
    lazy var runningButtonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = view.frame.height * (Double(48) / Double(1624))
        stackView.distribution = .fillEqually
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setAddView()
        setConstraint()
    }
    
    //MARK: - Set UI
    
    func setView() {
        let leadTrailInset = view.frame.width * (Double(48) / Double(750))
        view.backgroundColor = .white
        view.layoutMargins = UIEdgeInsets(top: 0, left: leadTrailInset, bottom: 0, right: leadTrailInset)
        view.addSubview(mainStackView)
    }
    
    func setAddView() {
        view.addSubview(advertisementContainer)
        view.addSubview(mainStackView)
        mainStackView.addArrangedSubview(locationButton)
        mainStackView.addArrangedSubview(labelStackView)
        labelStackView.addArrangedSubview(discussionLabel)
        labelStackView.addArrangedSubview(runningButtonStackView)
        runningButtonStackView.addArrangedSubview(individualRunningButton)
        runningButtonStackView.addArrangedSubview(crewRunningButton)
    }
    
    func setConstraint() {
        setAdverContainer()
        setMainStackViewConstraint()
        setLabelStackView()
        setRuningButtonStackView()
    }
    
    func setAdverContainer() {
        NSLayoutConstraint.activate([
            advertisementContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            advertisementContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            advertisementContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            advertisementContainer.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: CGFloat(Double(120) / Double(1624)))
        ])
    }
    
    func setMainStackViewConstraint() {
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: advertisementContainer.bottomAnchor, constant: view.frame.height * (Double(18) / Double(1624))),
            mainStackView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: view.frame.height * -(Double(68) / Double(1624)))
        ])
    }
    
    func setLabelStackView() {
        NSLayoutConstraint.activate([
            labelStackView.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor),
            labelStackView.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor),
            labelStackView.bottomAnchor.constraint(equalTo: mainStackView.bottomAnchor)
        ])
    }
    
    func setRuningButtonStackView() {
        NSLayoutConstraint.activate([
            runningButtonStackView.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor),
            runningButtonStackView.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor),
            runningButtonStackView.bottomAnchor.constraint(equalTo: mainStackView.bottomAnchor)
        ])
    }

}
