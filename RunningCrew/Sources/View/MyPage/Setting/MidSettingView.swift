//
//  MidSettingView.swift
//  RunningCrew
//
//  Created by 김기훈 on 2023/08/23.
//

import UIKit
import SnapKit

final class MidSettingView: UIStackView {
    
    lazy var runningTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "러닝 설정"
        
        return label
    }()
    
    lazy var audioStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        
        return stackView
    }()
    
    lazy var audioLabelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 5
        
        return stackView
    }()
    
    lazy var audioTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "오디오가이드"
        
        return label
    }()
    
    lazy var audioLabel: UILabel = {
        let label = UILabel()
        label.text = "오디오 가이드를 on/off 할 수 있습니다."
        
        return label
    }()
    
    lazy var audioSwitch: UISwitch = {
        let uiSwitch = UISwitch()
        
        return uiSwitch
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.axis = .vertical
        self.spacing = 20
        self.distribution = .fillProportionally
        addViews()
        setConstraint()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addViews() {
        self.addArrangedSubview(runningTitleLabel)
        
        self.addArrangedSubview(audioStackView)
        audioStackView.addArrangedSubview(audioLabelStackView)
        audioStackView.addArrangedSubview(audioSwitch)
        audioLabelStackView.addArrangedSubview(audioTitleLabel)
        audioLabelStackView.addArrangedSubview(audioLabel)
    }
    
    private func setConstraint() {
        audioStackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
        }
    }
}
