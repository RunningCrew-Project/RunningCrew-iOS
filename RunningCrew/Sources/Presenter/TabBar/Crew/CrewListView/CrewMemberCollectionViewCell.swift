//
//  CrewMemberCollectionViewCell.swift
//  RunningCrew
//
//  Created by Kim TaeSoo on 2023/04/12.
//

import UIKit
import SnapKit

class CrewMemberCollectionViewCell: UICollectionViewCell {
    lazy var memberImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .black
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = (self.bounds.height * 0.7) / 2
        

        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(memberImageView)
        memberImageView.snp.makeConstraints { make in
            make.center.equalTo(safeAreaLayoutGuide)
            make.height.width.equalTo(self.snp.width).multipliedBy(0.7)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
