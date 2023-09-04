//
//  CrewRunningScheduleCell.swift
//  RunningCrew
//
//  Created by 김기훈 on 2023/08/07.
//

import UIKit
import SnapKit

final class CrewRunningScheduleCell: UICollectionViewCell {
    
    static let identifier = "CrewRunningScheduleCell"
    
    lazy var timeLabel: UILabel = {
        let timeLabel = UILabel()
        
        return timeLabel
    }()
    
    lazy var titleLabel: UILabel = {
        let timeLabel = UILabel()
        
        return timeLabel
    }()
    
    lazy var headCountLabel: UILabel = {
        let timeLabel = UILabel()
        
        return timeLabel
    }()
    
    lazy var locationLabel: UILabel = {
        let timeLabel = UILabel()
        
        return timeLabel
    }()
    
    lazy var stateLabel: UILabel = {
        let timeLabel = UILabel()
        timeLabel.backgroundColor = .red
        
        return timeLabel
    }()
    
    private func addViews() {
        self.addSubview(timeLabel)
        self.addSubview(titleLabel)
        self.addSubview(headCountLabel)
        self.addSubview(locationLabel)
        self.addSubview(stateLabel)
    }
    
    private func setConstraint() {
        timeLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.leading.equalToSuperview()
        }
        
        headCountLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.leading.equalToSuperview()
        }
        
        locationLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.leading.equalTo(headCountLabel.snp.trailing)
        }
        
        stateLabel.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(80.0/344.0)
        }
    }
    
    func configure(crew: Crew) {
        headCountLabel.text = "\(crew.memberCount)"
        locationLabel.text = crew.dong
    }
}
