//
//  MenuBarCell.swift
//  RunningCrew
//
//  Created by JunHwan Kim on 2023/02/15.
//

import UIKit

class MenuBarCell: UICollectionViewCell {
    
    static let reusableIdentifier = "MenuBarCell"
    
    lazy var titleButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.lightGray, for: .normal)
        button.setTitleColor(.black, for: .selected)
        button.setTitleColor(.black, for: .highlighted)
        button.backgroundColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var itemTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override var isSelected: Bool {
        didSet {
            self.itemTitle.font = isSelected ? UIFont.boldSystemFont(ofSize: 16) : UIFont.systemFont(ofSize: 16)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        //contentView.addSubview(titleButton)
        contentView.addSubview(itemTitle)
        NSLayoutConstraint.activate([
//            titleButton.topAnchor.constraint(equalTo: contentView.topAnchor),
//            titleButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//            titleButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//            titleButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            itemTitle.centerXAnchor.constraint(equalTo: centerXAnchor),
            itemTitle.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
