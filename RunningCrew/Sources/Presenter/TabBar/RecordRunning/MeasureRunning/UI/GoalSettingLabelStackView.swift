//
//  GoalSettingStackView.swift
//  RunningCrew
//
//  Created by JunHwan Kim on 2023/02/26.
//

import UIKit

class GoalSettingLabelStackView: UIStackView {
    
    lazy var destinationLabel: UILabel = {
       let destinationLabel = UILabel()
        destinationLabel.translatesAutoresizingMaskIntoConstraints = false
        let font = UIFont(name: "NotoSansKR-Bold", size: 80)
        let style = NSMutableParagraphStyle()
        style.maximumLineHeight = 80
        style.minimumLineHeight = 80
        if let font = font {
            let attr: [NSAttributedString.Key: Any] = [
                .paragraphStyle: style,
                .font: font,
                .baselineOffset: -10
            ]
            let attrString = NSAttributedString(string: "5.00", attributes: attr)
            destinationLabel.attributedText = attrString
        }
        
        return destinationLabel
    }()
    
    lazy var underLineView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        axis = .vertical
        addArrangedSubview(destinationLabel)
        addArrangedSubview(underLineView)
        setUnderLineView()
    }
    
    func setUnderLineView() {
        NSLayoutConstraint.activate([
            underLineView.leadingAnchor.constraint(equalTo: leadingAnchor),
            underLineView.trailingAnchor.constraint(equalTo: trailingAnchor),
            underLineView.heightAnchor.constraint(equalToConstant: 3.0)
        ])
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
