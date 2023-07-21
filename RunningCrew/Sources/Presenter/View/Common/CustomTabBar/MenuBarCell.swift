//
//  MenuBarCell.swift
//  RunningCrew
//
//  Created by JunHwan Kim on 2023/02/15.
//

import UIKit
import SnapKit

final class MenuBarCell: UICollectionViewCell {
    
    lazy var itemTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "NotoSansKR-Medium", size: 16)
        return label
    }()
    
    lazy var currentMarkView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        
        return view
    }()
    
    static let reusableIdentifier = "MenuBarCell"
    
    override var isSelected: Bool {
        didSet {
            self.itemTitle.font = isSelected ? UIFont(name: "NotoSansKR-Bold", size: 16) : UIFont(name: "NotoSansKR-Medium", size: 16)
            self.currentMarkView.backgroundColor = isSelected ? .black : .lightGray
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addViews() {
        addSubview(itemTitle)
        addSubview(currentMarkView)
    }
    
    private func setupView() {
        itemTitle.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
        
        currentMarkView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(4)
        }
    }
}
