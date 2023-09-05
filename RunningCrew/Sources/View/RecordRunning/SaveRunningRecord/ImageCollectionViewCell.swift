//
//  ImageCollectionViewCell.swift
//  RunningCrew
//
//  Created by JunHwan Kim on 2023/03/09.
//

import UIKit
import SnapKit

final class ImageCollectionViewCell: UICollectionViewCell {
    
    static let reusableIdentifier = "ImageCollectionViewCell"
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        setConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addViews() {
        self.addSubview(imageView)
        self.addSubview(deleteButton)
    }
    
    private func setConstraint() {
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        deleteButton.snp.makeConstraints {
            $0.top.trailing.equalToSuperview()
        }
    }
}
