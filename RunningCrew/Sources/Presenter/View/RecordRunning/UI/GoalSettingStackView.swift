//
//  DestinationStackView.swift
//  RunningCrew
//
//  Created by JunHwan Kim on 2023/02/25.
//

import UIKit
import SnapKit

enum GoalType {
    case distance
    case time
}

final class GoalSettingStackView: UIStackView {
    
    lazy var destinationLabel: UILabel = {
        let destinationLabel = UILabel()
        destinationLabel.font = UIFont(name: "NotoSansKR-Bold", size: 80)
        
        return destinationLabel
    }()
    
    lazy var underLineView: UIView = {
       let view = UIView()
        view.backgroundColor = .darkModeBasicColor
        
        return view
    }()
    
    lazy var currentStringLabelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        
        return stackView
    }()
    
    lazy var currentLabel: UILabel = {
        let label = UILabel()
        label.text = "킬로미터"
        label.font = UIFont(name: "NotoSansKR-Medium", size: 22.0)
        label.sizeToFit()
        
        return label
    }()
    
    lazy var buttonConfiguration: UIButton.Configuration = {
        var config = UIButton.Configuration.plain()
        var imageConfig = UIImage.SymbolConfiguration(pointSize: 20)
        config.preferredSymbolConfigurationForImage = imageConfig
        
        return config
    }()
    
    lazy var beforeButtonBackgroundView: UIView = {
       let view = UIView()
        view.backgroundColor = .clear
        
        return view
    }()
    
    lazy var beforeButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "chevron.backward")?.resizeImageTo(size: CGSize(width: 20, height: 30))?.withRenderingMode(.alwaysTemplate)
        button.setImage(image, for: .normal)
        button.tintColor = .darkModeBasicColor
        
        return button
    }()
    
    lazy var nextButtonBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        
        return view
    }()
    
    lazy var nextButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "chevron.forward")?.resizeImageTo(size: CGSize(width: 20, height: 30))?.withRenderingMode(.alwaysTemplate)
        button.setImage(image, for: .normal)
        button.tintColor = .darkModeBasicColor
        
        return button
    }()
    
    init() {
        super.init(frame: .zero)
        addViews()
        configureUI()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addViews() {
        addArrangedSubview(destinationLabel)
        addArrangedSubview(underLineView)
        addArrangedSubview(currentStringLabelStackView)
        currentStringLabelStackView.addArrangedSubview(beforeButtonBackgroundView)
        currentStringLabelStackView.addArrangedSubview(currentLabel)
        currentStringLabelStackView.addArrangedSubview(nextButtonBackgroundView)
        beforeButtonBackgroundView.addSubview(beforeButton)
        nextButtonBackgroundView.addSubview(nextButton)
    }
    
    private func configureUI() {
        axis = .vertical
        alignment = .center
        
        destinationLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(212.0/314.0)
        }
        
        underLineView.snp.makeConstraints {
            $0.top.equalTo(destinationLabel.snp.bottom)
            $0.leading.trailing.equalTo(destinationLabel)
            $0.height.equalTo(3)
        }

        currentLabel.snp.makeConstraints {
            $0.height.greaterThanOrEqualTo(44)
        }

        beforeButtonBackgroundView.snp.makeConstraints {
            $0.width.height.greaterThanOrEqualTo(currentLabel.snp.height)
        }

        beforeButton.snp.makeConstraints {
            $0.top.leading.bottom.trailing.equalTo(beforeButtonBackgroundView)
        }

        nextButtonBackgroundView.snp.makeConstraints {
            $0.width.height.greaterThanOrEqualTo(currentLabel.snp.height)
        }

        nextButton.snp.makeConstraints {
            $0.top.leading.bottom.trailing.equalTo(nextButtonBackgroundView)
        }
    }
    
    func changeGoalType(type: GoalType) {
        switch type {
        case .distance:
            self.currentLabel.text = "킬로미터"
            self.beforeButton.isHidden = true
            self.nextButton.isHidden = false
        case .time:
            self.currentLabel.text = "시간 : 분"
            self.beforeButton.isHidden = false
            self.nextButton.isHidden = true
        }
    }
}
