//
//  MyPageMyRunningViewCell.swift
//  RunningCrew
//
//  Created by Dongwan Ryoo on 2023/05/05.
//

import UIKit
import SnapKit

final class MyPageMyRunningViewCell: UICollectionViewCell {
    
    static let identifier = "MyPageMyRunningCollectionViewCell"

    lazy var runningTitle: UILabel = {
        let label = UILabel()
        label.text = "B크루 정기러닝"
        label.font = UIFont(name: "NotoSansKR-Bold", size: 40)
        label.textColor = .black
        label.textAlignment = .left
        
        return label
    }()
    
    lazy var secondLineStackView: UIStackView = {
        let stackveiw = UIStackView()
        stackveiw.alignment = .leading
        
        return stackveiw
    }()
    
    lazy var runningDate: UILabel = {
        let label = UILabel()
        label.text = "1월 19일 20시"
        label.font = UIFont(name: "NotoSansKR-Bold", size: 14)
        label.textColor = .black
        label.textAlignment = .left
        
        return label
    }()
    
    lazy var runningPlace: UILabel = {
        let label = UILabel()
        label.text = "서울시 광진구"
        label.font = UIFont(name: "NotoSansKR-Bold", size: 14)
        label.textColor = .black
        label.textAlignment = .left
        
        return label
    }()
    
    lazy var thirdLineStackView: UIStackView = {
        let stackveiw = UIStackView()
        stackveiw.alignment = .leading
        
        return stackveiw
    }()
    
    lazy var runningDistance: UILabel = {
        let label = UILabel()
        label.text = "거리 5Km"
        label.font = UIFont(name: "NotoSansKR-Bold", size: 14)
        label.textColor = .black
        label.textAlignment = .left
        
        return label
    }()
    
    lazy var runningTime: UILabel = {
        let label = UILabel()
        label.text = "시간 33:30"
        label.font = UIFont(name: "NotoSansKR-Bold", size: 14)
        label.textColor = .black
        label.textAlignment = .left
        
        return label
    }()
    
    lazy var runningAverage: UILabel = {
        let label = UILabel()
        label.text = "평균 페이스 6'42'"
        label.font = UIFont(name: "NotoSansKR-Bold", size: 14)
        label.textColor = .black
        label.textAlignment = .left
        
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
    
    private func addViews() {
        addSubview(runningTitle)
        addSubview(secondLineStackView)
        addSubview(thirdLineStackView)
        
        secondLineStackView.addArrangedSubview(runningDate)
        secondLineStackView.addArrangedSubview(runningPlace)
        
        thirdLineStackView.addArrangedSubview(runningDistance)
        thirdLineStackView.addArrangedSubview(runningTime)
        thirdLineStackView.addArrangedSubview(runningAverage)
    }
    
    private func setConstraint() {
        runningTitle.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview()
        }
        
        secondLineStackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalTo(runningTitle.snp.bottom).offset(4)
        }
        
        thirdLineStackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalTo(secondLineStackView.snp.bottom).offset(19)
        }
    }
    
    func setUpUI() {
        self.layer.cornerRadius = 20
        self.clipsToBounds = true
        self.backgroundColor = UIColor.lightGray

        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.3
        self.layer.shadowRadius = 10
        self.layer.shadowOffset = CGSize(width: 5, height: 5)
        self.layer.masksToBounds = false
    }
}

extension MyPageMyRunningViewCell {
    func configure(runningRecord: AllRunningRecordContent) {
        runningTitle.text = runningRecord.title
        runningDate.text = runningRecord.startDateTime
        runningPlace.text = runningRecord.location
        runningDistance.text = "\(runningRecord.runningDistance)"
        runningTime.text = "\(runningRecord.runningTime)"
        runningAverage.text = "\(runningRecord.runningFace)"
    }
}
