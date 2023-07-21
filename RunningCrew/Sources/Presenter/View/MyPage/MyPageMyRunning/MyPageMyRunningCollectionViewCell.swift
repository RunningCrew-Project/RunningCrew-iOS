//
//  CollectionViewCell.swift
//  RunningCrew
//
//  Created by Dongwan Ryoo on 2023/05/05.
//

import UIKit

class MyPageMyRunningCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "MyPageMyRunningCollectionViewCell"

    lazy var runningTitle:UILabel = {
        let label = UILabel()
        label.text = "B크루 정기러닝"
        label.font = UIFont(name: "NotoSansKR-Bold", size: 40)
        label.textColor = .black
        label.textAlignment = .left
        
        return label
    }()
    
    lazy var runningDate:UILabel = {
        let label = UILabel()
        label.text = "1월 19일 20시"
        label.font = UIFont(name: "NotoSansKR-Bold", size: 14)
        label.textColor = .black
        label.textAlignment = .left
        
        return label
    }()
    
    
    lazy var runningPlace:UILabel = {
        let label = UILabel()
        label.text = "서울시 광진구"
        label.font = UIFont(name: "NotoSansKR-Bold", size: 14)
        label.textColor = .black
        label.textAlignment = .left
        
        return label
    }()
    
    
    lazy var secondLineStackView:UIStackView = {
        let stackveiw = UIStackView()
        stackveiw.alignment = .leading
        
        return stackveiw
        
    }()
    
    
    lazy var runningDistance:UILabel = {
        let label = UILabel()
        label.text = "거리 5Km"
        label.font = UIFont(name: "NotoSansKR-Bold", size: 14)
        label.textColor = .black
        label.textAlignment = .left
        
        return label
    }()
    
    lazy var runningTime:UILabel = {
        let label = UILabel()
        label.text = "시간 33:30"
        label.font = UIFont(name: "NotoSansKR-Bold", size: 14)
        label.textColor = .black
        label.textAlignment = .left
        
        return label
    }()
    
    lazy var runningEverage:UILabel = {
        let label = UILabel()
//        label.text = "평균 페이스 6'42'"
        label.font = UIFont(name: "NotoSansKR-Bold", size: 14)
        label.textColor = .black
        label.textAlignment = .left
        
        return label
    }()
    
    lazy var thirdLineStackView:UIStackView = {
        let stackveiw = UIStackView()
        stackveiw.alignment = .leading
        
        return stackveiw
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setCell()
        setShadow()
        setView()
        setConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCell (){
        contentView.layer.cornerRadius = 20
        contentView.clipsToBounds = true
        contentView.backgroundColor = UIColor.lightGray
    }
    
    func setShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowRadius = 10
        layer.shadowOffset = CGSize(width: 5, height: 5)
        layer.masksToBounds = false
    }
    
    func setView(){
        contentView.addSubview(runningTitle)
        contentView.addSubview(secondLineStackView)
        contentView.addSubview(thirdLineStackView)
        setsecondLineStackView()
        setthirdLineStackView()
        
    }
    
    
    func setsecondLineStackView(){
        secondLineStackView.addArrangedSubview(runningDate)
        secondLineStackView.addArrangedSubview(runningPlace)
    }
    
    
    func setthirdLineStackView(){
        thirdLineStackView.addArrangedSubview(runningDistance)
        thirdLineStackView.addArrangedSubview(runningTime)
        thirdLineStackView.addArrangedSubview(runningEverage)
        
    }
    
    
    func setConstraint(){
        runningTitleConstraint()
        secondLineStackViewConstriant()
        runningDateConstraint()
        runningPlaceConstraint()
        thirdLineStackViewConstraint()
        runningDistanceConstraint()
        runningTimeConstraint()
        runningEverageConstraint()
        cellConstraint()

    }
    
    func cellConstraint(){
        contentView.snp.makeConstraints { make in
            make.width.equalTo(327)
            make.height.equalTo(125)
            make.leading.equalTo(15)
            
        }
        
    }
    
    func runningTitleConstraint(){
        runningTitle.snp.makeConstraints { make in
            make.leading.equalTo(contentView.snp.leading).offset(16)
            make.top.equalTo(contentView.snp.top)
        }
        
    }
    
    func secondLineStackViewConstriant() {
        secondLineStackView.snp.makeConstraints { make in
            make.leading.equalTo(contentView.snp.leading).offset(16)
            make.top.equalTo(runningTitle.snp.bottom).offset(4)
        }

        
    }
    
    func runningDateConstraint(){
        
    }
    
    func runningPlaceConstraint(){
        
    }
    
    func thirdLineStackViewConstraint() {
        thirdLineStackView.snp.makeConstraints { make in
            make.leading.equalTo(contentView.snp.leading).offset(16)
            make.top.equalTo(secondLineStackView.snp.bottom).offset(19)
        }
        
    }
    
    func  runningDistanceConstraint(){
        
    }
    
    func runningTimeConstraint(){
        
    }
    
    func runningEverageConstraint(){
        
    }
   
    
}
