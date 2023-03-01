//
//  DestinationStackView.swift
//  RunningCrew
//
//  Created by JunHwan Kim on 2023/02/25.
//

import UIKit

class GoalSettingStackView: UIStackView {

    lazy var goalSettingLabelStackView: GoalSettingLabelStackView = {
        let stackView = GoalSettingLabelStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    lazy var currentLabelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        
        return stackView
    }()
    
    lazy var currentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        let font = UIFont(name: "NotoSansKR-Medium", size: 22.0)
        let style = NSMutableParagraphStyle()
        style.minimumLineHeight = 32
        style.maximumLineHeight = 32
        if let font = font {
            let attr: [NSAttributedString.Key: Any] = [
                .paragraphStyle: style,
                .font: font,
            ]
            let attrString = NSAttributedString(string: "킬로미터", attributes: attr)
            label.attributedText = attrString
        }
        return label
    }()
    
    lazy var buttonConfiguration: UIButton.Configuration = {
        var config = UIButton.Configuration.plain()
        var imageConfig = UIImage.SymbolConfiguration(pointSize: 20)
        config.preferredSymbolConfigurationForImage = imageConfig
        return config
    }()
    
    lazy var beforeButton: UIButton = {
        let button = UIButton(configuration: buttonConfiguration)
        button.configuration?.image = UIImage(systemName: "chevron.left")
        button.tintColor = .black
        
        return button
    }()
    
    lazy var nextButton: UIButton = {
        let button = UIButton(configuration: buttonConfiguration)
        button.configuration?.image = UIImage(systemName: "chevron.right")
        button.tintColor = .black
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setCurrentLabelStackView()
        setDestinationStackView()
        setButtonConstraint()
        spacing = 11
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setDestinationStackView() {
        axis = .vertical
        alignment = .center
        addArrangedSubview(goalSettingLabelStackView)
        addArrangedSubview(currentLabelStackView)
    }
    
    private func setCurrentLabelStackView() {
        currentLabelStackView.addArrangedSubview(beforeButton)
        currentLabelStackView.addArrangedSubview(currentLabel)
        currentLabelStackView.addArrangedSubview(nextButton)
    }
    
    private func setButtonConstraint() {
        NSLayoutConstraint.activate([
            beforeButton.heightAnchor.constraint(equalToConstant: 40),
            beforeButton.widthAnchor.constraint(equalToConstant: 40),
            
            nextButton.heightAnchor.constraint(equalToConstant: 40),
            nextButton.widthAnchor.constraint(equalToConstant: 40)
        ])
    }
    
}
