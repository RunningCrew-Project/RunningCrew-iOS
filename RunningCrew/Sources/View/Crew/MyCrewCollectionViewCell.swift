//
//  CrewMemberCollectionViewCell.swift
//  RunningCrew
//
//  Created by Kim TaeSoo on 2023/04/12.
//

import UIKit
import SnapKit
import Kingfisher

final class MyCrewCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "MyCrewCollectionViewCell"
    
    lazy var crewImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .black
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = (self.bounds.height * 0.7) / 2
        
        return imageView
    }()
    
    lazy var crewNameLabel: UILabel = {
        let label = UILabel()
        
        return label
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        setConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MyCrewCollectionViewCell {
    private func addViews() {
        self.addSubview(crewImageView)
        self.addSubview(crewNameLabel)
    }
    
    private func setConstraint() {
        crewImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalTo(safeAreaLayoutGuide)
            make.height.width.equalTo(self.snp.width).multipliedBy(0.7)
        }
        
        crewNameLabel.snp.makeConstraints {
            $0.centerX.equalTo(safeAreaLayoutGuide)
            $0.top.equalTo(crewImageView.snp.bottom)
            $0.bottom.equalToSuperview()
        }
    }
    
    func configure(crew: Crew) {
        let url = URL(string: crew.crewImgURL)
        crewImageView.kf.setImage(with: url)
        crewNameLabel.text = crew.name
    }
}
