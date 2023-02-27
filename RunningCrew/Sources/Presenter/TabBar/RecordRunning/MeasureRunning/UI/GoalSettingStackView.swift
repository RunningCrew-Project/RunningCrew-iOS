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
        stackView.axis = .vertical
        
        return stackView
    }()
    
    lazy var currentLabelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        
        return stackView
    }()
    
    lazy var currentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "NotoSansKR-Medium", size: 22.0)
        label.text = "킬로미터"
        return label
    }()
    
    lazy var nextButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.imageView?.image = UIImage(systemName: "chevron.right")
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setCurrentLabelStackView()
        setDestinationStackView()
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
        currentLabelStackView.addArrangedSubview(currentLabel)
        currentLabelStackView.addArrangedSubview(nextButton)
    }
    
}
