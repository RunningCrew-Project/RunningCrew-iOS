//
//  CrewListCollectionViewCell.swift
//  RunningCrew
//
//  Created by Kim TaeSoo on 2023/04/12.
//

import UIKit
import SnapKit
import Kingfisher

final class RecommendCrewCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "RecommendCrewCollectionViewCell"
    
    lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.layer.masksToBounds = true
        image.layer.cornerRadius = (self.bounds.height - 24) / 2
        image.backgroundColor = .green
        
        return image
    }()
    
    let crewNameLabel: UILabel = {
        let label = UILabel()
        label.text = "서초구 크루"
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    let crewIntroduceLabel: UILabel = {
        let label = UILabel()
        label.text = "크루소개크루소개크루소개크루소개크루소개크루소개크루소개크루소개크루소개크루소개크루소개"
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    let crewBriefLabel: UILabel = {
        let label = UILabel()
        
        let attributedString = NSMutableAttributedString(string: "")
        let imageAttachment = NSTextAttachment()
        
        let image = UIImage(systemName: "person.fill")
        image?.withTintColor(.darkGray)
        imageAttachment.image = image
        imageAttachment.bounds = CGRect(x: 0, y: 0, width: 8, height: 8)
        attributedString.append(NSAttributedString(attachment: imageAttachment))
        attributedString.append(NSAttributedString(string: "131 · 서울 서초구", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)]))
        label.attributedText = attributedString
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

extension RecommendCrewCollectionViewCell {
    private func addViews() {
        self.addSubview(imageView)
        self.addSubview(crewNameLabel)
        self.addSubview(crewIntroduceLabel)
        self.addSubview(crewBriefLabel)
    }
    
    private func setConstraint() {
        let topLeading = 12
        
        imageView.snp.makeConstraints { make in
            make.leading.equalTo(safeAreaLayoutGuide)
            make.verticalEdges.equalTo(safeAreaLayoutGuide).inset(topLeading)
            make.width.equalTo(imageView.snp.height)
        }
        
        crewNameLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(topLeading)
            make.leading.equalTo(imageView.snp.trailing).offset(topLeading)
            make.trailing.equalTo(safeAreaLayoutGuide).inset(topLeading)
        }
        
        crewIntroduceLabel.snp.makeConstraints { make in
            make.top.equalTo(crewNameLabel.snp.bottom)
            make.leading.equalTo(imageView.snp.trailing).offset(topLeading)
            make.trailing.equalTo(safeAreaLayoutGuide).inset(topLeading)
        }
        
        crewBriefLabel.snp.makeConstraints { make in
            make.top.equalTo(crewIntroduceLabel.snp.bottom)
            make.leading.equalTo(imageView.snp.trailing).offset(topLeading)
            make.bottom.equalTo(safeAreaLayoutGuide).inset(topLeading)
        }
    }
    
    func configure(recommendCrew: GuRecommendCrew) {
        let url = URL(string: recommendCrew.crewImgURL)
        imageView.kf.setImage(with: url)
        crewNameLabel.text = recommendCrew.name
        crewIntroduceLabel.text = recommendCrew.introduction
        crewBriefLabel.text = "\(recommendCrew.memberCount) · "
    }
}
