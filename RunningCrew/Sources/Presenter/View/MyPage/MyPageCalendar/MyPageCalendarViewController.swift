//
//  MyPageCalendarViewController.swift
//  RunningCrew
//
//  Created by Dongwan Ryoo on 2023/04/09.
//

import UIKit
import SnapKit

class MyPageCalendarViewController: UIViewController {
    
    lazy var calendar = MyPageClendarView()
    lazy var collectionview = MyRunningCollectionView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setConstraint()
        
       
    }
    func setView(){
        view.backgroundColor = .white
        view.addSubview(calendar)
        view.addSubview(collectionview)
    }
    
    func setConstraint() {
        calendarConstraint()
        collectionviewConstraint()
    }
    
    
    func calendarConstraint(){
        calendar.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalToSuperview()
        }
        
    }
    
    func collectionviewConstraint(){
        collectionview.snp.makeConstraints { make in
            make.leading.bottom.trailing.equalToSuperview()
            make.top.equalTo(calendar.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
        }
        
    }


}
