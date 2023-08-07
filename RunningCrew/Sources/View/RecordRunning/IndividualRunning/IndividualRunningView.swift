//
//  RunningStartView.swift
//  RunningCrew
//
//  Created by 김기훈 on 2023/07/15.
//

import UIKit
import NMapsMap
import SnapKit

final class IndividualRunningView: BaseView {
    
    lazy var mapView: NMFNaverMapView = {
        let mapView = NMFNaverMapView()
        mapView.mapView.zoomLevel = 16
        mapView.showLocationButton = false
        mapView.showZoomControls = false
        
        return mapView
    }()
    
    lazy var goalSettingStackView: GoalSettingStackView = {
        let goalSettingStackView = GoalSettingStackView()
        goalSettingStackView.goalLabel.isUserInteractionEnabled = true
        goalSettingStackView.beforeButton.isHidden = true
        
        return goalSettingStackView
    }()
    
    lazy var startButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .tabBarSelect
        button.setTitle("시작", for: .normal)
        button.titleLabel?.font = UIFont(name: "NotoSansKR-Bold", size: 24.0)
        button.clipsToBounds = true
        button.layer.cornerCurve = .circular
        
        return button
    }()
    
    override func addViews() {
        self.addSubview(mapView)
        self.addSubview(goalSettingStackView)
        self.addSubview(startButton)
    }
    
    override func setConstraint() {
        mapView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().multipliedBy(0.45)
        }
        
        goalSettingStackView.snp.makeConstraints {
            $0.bottom.equalToSuperview().multipliedBy(CGFloat(Double(1142) / Double(1624)))
            $0.centerX.equalToSuperview()
        }

        startButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().multipliedBy(CGFloat(Double(1452) / Double(1624)))
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(self.safeAreaLayoutGuide.snp.width).multipliedBy(CGFloat(Double(180) / Double(750)))
        }
    }
    
    override func setViewStyle() {
        startButton.layer.cornerRadius = startButton.frame.width / 2
    }
}

extension IndividualRunningView {
    func cameraUpdate(latitude: Double, longitude: Double) {
        let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: latitude, lng: longitude))
        cameraUpdate.animation = .fly
        
        mapView.mapView.moveCamera(cameraUpdate)
        mapView.mapView.positionMode = .direction
    }
}
