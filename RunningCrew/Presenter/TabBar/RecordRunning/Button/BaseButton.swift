//
//  BaseButton.swift
//  RunningCrew
//
//  Created by JunHwan Kim on 2023/02/14.
//

import UIKit

class BaseButton: UIButton {

    let discussionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setTitleLabel()
        setDiscussionLabel()
        print(layoutMargins)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        clipsToBounds = true
        self.layer.cornerRadius = 10
        self.layoutMargins = UIEdgeInsets(top: 7, left: 7, bottom: 7, right: 7)
    }
    
    func setTitleLabel() {
        guard let titleLabel = titleLabel else { return }
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        self.setTitleColor(.white, for: .normal)
    }
    
    func setDiscussionLabel() {
        addSubview(discussionLabel)
        discussionLabel.font = UIFont.boldSystemFont(ofSize: 12)
        NSLayoutConstraint.activate([
            discussionLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            discussionLabel.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor)
        ])
        
    }
    
}
