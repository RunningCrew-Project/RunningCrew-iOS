//
//  CrewGenerateView.swift
//  RunningCrew
//
//  Created by Kim TaeSoo on 2023/04/15.
//

import UIKit
import SnapKit

final class CrewGenerateView: BaseView {
    
    lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    lazy var setCrewLabel: UILabel = {
        let label = UILabel()
        label.text = "크루명"
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    lazy var crewNameTfView: GenerateTextFieldView = {
        let tfView = GenerateTextFieldView(placeholder: "크루명을 입력해주세요")
        
        return tfView
    }()
    
    lazy var bigRegionButton: RegionSelectButton = {
        let button = RegionSelectButton(actionNameArr: ["서울특별시", "경기도"])
        button.setTitle("시 / 도", for: .normal)
        return button
    }()
    
    lazy var middleRegionButton: RegionSelectButton = {
        let button = RegionSelectButton(actionNameArr: ["서초구", "강남구", "성동구"])
        button.setTitle("군 / 구", for: .normal)
        return button
    }()
    
    lazy var smallRegionButton: RegionSelectButton = {
        let button = RegionSelectButton(actionNameArr: ["서초동", "양재동", "주암동"])
        button.setTitle("읍 / 면 / 동", for: .normal)
        return button
    }()
    
    lazy var regionLabel: UILabel = {
        let label = UILabel()
        label.text = "활동 지역"
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    lazy var regionStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.addArrangedSubview(bigRegionButton)
        stackView.addArrangedSubview(middleRegionButton)
        stackView.addArrangedSubview(smallRegionButton)
        stackView.distribution = .fillEqually
        stackView.spacing = 12
        return stackView
    }()
    
    lazy var crewIntroduceLabel: UILabel = {
        let label = UILabel()
        label.text = "크루소개"
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    lazy var crewIntroduceTfView: GenerateTextFieldView = {
        let tfView = GenerateTextFieldView(placeholder: "크루소개를 작성해 주세요")
        return tfView
    }()
    
    lazy var generateButton: UIButton = {
        let button = UIButton()
        button.setTitle("크루 생성하기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "NotoSansKR-Bold", size: 24)
        button.backgroundColor = .darkGreen
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func addViews() {
        self.addSubview(closeButton)
        self.addSubview(setCrewLabel)
        self.addSubview(crewNameTfView)
        self.addSubview(regionLabel)
        self.addSubview(regionStackView)
        self.addSubview(crewIntroduceLabel)
        self.addSubview(crewIntroduceTfView)
        self.addSubview(generateButton)
    }

    override func setConstraint() {
        let topLeading = 16
        let padding = 20
        
        closeButton.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(topLeading)
            make.leading.equalTo(safeAreaLayoutGuide).offset(topLeading)
        }
        
        setCrewLabel.snp.makeConstraints { make in
            make.top.equalTo(closeButton.snp.bottom).offset(topLeading)
            make.leading.equalTo(safeAreaLayoutGuide).offset(topLeading)
        }
        
        crewNameTfView.snp.makeConstraints { make in
            make.top.equalTo(setCrewLabel.snp.bottom).offset(topLeading)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(topLeading)
        }
        
        regionLabel.snp.makeConstraints { make in
            make.top.equalTo(crewNameTfView.snp.bottom).offset(padding)
            make.leading.equalTo(safeAreaLayoutGuide).offset(topLeading)
        }
        
        regionStackView.snp.makeConstraints { make in
            make.top.equalTo(regionLabel.snp.bottom).offset(topLeading)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(topLeading)
            make.height.equalTo(36)
        }
        
        crewIntroduceLabel.snp.makeConstraints { make in
            make.top.equalTo(regionStackView.snp.bottom).offset(padding)
            make.leading.equalTo(safeAreaLayoutGuide).offset(topLeading)
        }
        
        crewIntroduceTfView.snp.makeConstraints { make in
            make.top.equalTo(crewIntroduceLabel.snp.bottom).offset(topLeading)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(topLeading)
        }
        
        generateButton.snp.makeConstraints { make in
            make.bottom.equalTo(keyboardLayoutGuide.snp.top)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(topLeading)
            make.height.equalTo(52)
        }
    }
}
