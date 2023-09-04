//
//  SaveRecordRunningView.swift
//  RunningCrew
//
//  Created by 김기훈 on 2023/08/11.
//

import UIKit
import NMapsMap
import PhotosUI
import SnapKit

final class SaveRecordRunningView: BaseView {
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    lazy var containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var currentTimeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        
        return label
    }()
    
    lazy var crewNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24)
        
        return label
    }()
    
    lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .darkModeBasicColor
        button.sizeToFit()
        return button
    }()
    
    lazy var kilometerNumberLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 92)
        label.textColor = .darkGreen
        
        return label
    }()
    
    lazy var kilometerTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "킬로미터"
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .darkGreen
        
        return label
    }()
    
    lazy var averagePaceNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "00'00\""
        label.font = UIFont.systemFont(ofSize: 28)
        
        return label
    }()
    
    lazy var averagePaceTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "평균 페이스"
        label.font = UIFont.systemFont(ofSize: 12)
        
        return label
    }()
    
    lazy var timeNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "00:00:00"
        label.font = UIFont.systemFont(ofSize: 28)
        
        return label
    }()
    
    lazy var timeTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "시간"
        label.font = UIFont.systemFont(ofSize: 12)
        
        return label
    }()
    
    lazy var caloriesNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "0000"
        label.font = UIFont.systemFont(ofSize: 28)
        
        return label
    }()
    
    lazy var caloriesTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "칼로리"
        label.font = UIFont.systemFont(ofSize: 12)
        
        return label
    }()
    
    lazy var mapView: NMFNaverMapView = {
        let mapView = NMFNaverMapView()
        mapView.mapView.zoomLevel = 16
        mapView.showLocationButton = false
        mapView.showZoomControls = false
        mapView.layer.borderWidth = 0.5
        mapView.layer.borderColor = UIColor.black.cgColor
        
        return mapView
    }()
    
    lazy var addImageTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "이미지 추가하기"
        label.font = UIFont.systemFont(ofSize: 16)
        
        return label
    }()
    
    lazy var addImageView: UIView = {
        let view = UIView()
        
        let path = UIBezierPath(rect: view.bounds)
        let borderLayer = CAShapeLayer()
        borderLayer.strokeColor = UIColor.gray.cgColor
        borderLayer.fillColor = UIColor.clear.cgColor
        borderLayer.lineWidth = 3
        borderLayer.lineDashPattern = [3, 3]
        borderLayer.path = path.cgPath
        view.layer.addSublayer(borderLayer)
        
        return view
    }()
    
    lazy var addImageButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = .darkGray
        button.isUserInteractionEnabled = false
        return button
    }()
    
    lazy var imageCountLabel: UILabel = {
        let label = UILabel()
        label.text = "0 / 5"
        label.textColor = .darkGray
        label.isUserInteractionEnabled = false
        
        return label
    }()
    
    lazy var imageCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: ImageCollectionViewCell.reusableIdentifier)
        collectionView.delegate = self
        
        return collectionView
    }()
    
    lazy var contentTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "내용 추가하기"
        label.font = UIFont.systemFont(ofSize: 16)
        
        return label
    }()
    
    lazy var contentTextField: UITextField = {
        let textField = UITextField()
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor.black.cgColor
        textField.placeholder = "내용을 입력하세요."
        
        return textField
    }()
    
    lazy var saveButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.setTitle("러닝 저장하기", for: .normal)
        button.backgroundColor = .darkGreen
        
        return button
    }()
    
    lazy var needLogInLabel: UILabel = {
        let label = UILabel()
        label.text = "러닝 저장을 위해서는 로그인이 필요합니다."
        return label
    }()
    
    lazy var finishButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.setTitle("러닝 종료하기", for: .normal)
        button.backgroundColor = .darkGreen
        
        return button
    }()
    
    override func addViews() {
        self.addSubview(scrollView)
        scrollView.addSubview(containerView)
        
        containerView.addSubview(currentTimeLabel)
        containerView.addSubview(crewNameLabel)
        containerView.addSubview(closeButton)
        containerView.addSubview(kilometerNumberLabel)
        containerView.addSubview(kilometerTitleLabel)
        containerView.addSubview(averagePaceNumberLabel)
        containerView.addSubview(averagePaceTitleLabel)
        containerView.addSubview(timeNumberLabel)
        containerView.addSubview(timeTitleLabel)
        containerView.addSubview(caloriesNumberLabel)
        containerView.addSubview(caloriesTitleLabel)
        containerView.addSubview(mapView)
        containerView.addSubview(addImageTitleLabel)
        containerView.addSubview(addImageView)
        
        addImageView.addSubview(addImageButton)
        addImageView.addSubview(imageCountLabel)
        
        containerView.addSubview(imageCollectionView)
        containerView.addSubview(contentTitleLabel)
        containerView.addSubview(contentTextField)
        containerView.addSubview(saveButton)
        containerView.addSubview(needLogInLabel)
        containerView.addSubview(finishButton)
    }
    
    override func setConstraint() {
        scrollView.snp.makeConstraints {
            $0.edges.equalTo(safeAreaLayoutGuide)
        }
        
        containerView.snp.makeConstraints {
            $0.top.bottom.centerX.equalToSuperview()
            $0.width.greaterThanOrEqualToSuperview().inset(20)
        }
        
        currentTimeLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.leading.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.8)
        }
        
        crewNameLabel.snp.makeConstraints {
            $0.top.equalTo(currentTimeLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview()
        }
        
        closeButton.snp.makeConstraints {
            $0.top.trailing.equalToSuperview().offset(10)
            $0.width.equalToSuperview().multipliedBy(0.15)
            $0.height.equalTo(closeButton.snp.width)
        }
        
        closeButton.imageView?.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(0)
        }
        
        kilometerNumberLabel.snp.makeConstraints {
            $0.top.equalTo(crewNameLabel.snp.bottom)
            $0.leading.equalToSuperview()
        }
        
        kilometerTitleLabel.snp.makeConstraints {
            $0.top.equalTo(kilometerNumberLabel.snp.bottom)
            $0.leading.equalToSuperview()
        }
        
        averagePaceNumberLabel.snp.makeConstraints {
            $0.top.equalTo(kilometerTitleLabel.snp.bottom).offset(20)
            $0.leading.equalToSuperview()
        }
        
        averagePaceTitleLabel.snp.makeConstraints {
            $0.top.equalTo(averagePaceNumberLabel.snp.bottom)
            $0.centerX.equalTo(averagePaceNumberLabel)
        }
        
        timeNumberLabel.snp.makeConstraints {
            $0.top.equalTo(averagePaceNumberLabel)
            $0.centerX.equalToSuperview()
        }
        
        timeTitleLabel.snp.makeConstraints {
            $0.top.equalTo(averagePaceTitleLabel)
            $0.centerX.equalTo(timeNumberLabel)
        }
        
        caloriesNumberLabel.snp.makeConstraints {
            $0.top.equalTo(averagePaceNumberLabel)
            $0.trailing.equalToSuperview()
        }
        
        caloriesTitleLabel.snp.makeConstraints {
            $0.top.equalTo(averagePaceTitleLabel)
            $0.centerX.equalTo(caloriesNumberLabel)
        }
        
        mapView.snp.makeConstraints {
            $0.top.equalTo(averagePaceTitleLabel.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(safeAreaLayoutGuide).multipliedBy(0.5)
        }
        
        addImageTitleLabel.snp.makeConstraints {
            $0.top.equalTo(mapView.snp.bottom).offset(20)
            $0.leading.equalToSuperview()
        }
        
        addImageView.snp.makeConstraints {
            $0.top.equalTo(addImageTitleLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.3)
            $0.height.equalTo(addImageView.snp.width)
        }
        
        addImageButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().multipliedBy(0.5)
            $0.width.equalToSuperview().multipliedBy(0.4)
            $0.height.equalTo(addImageButton.snp.width)
        }
        
        addImageButton.imageView?.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(0)
        }
        
        imageCountLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().multipliedBy(1.4)
        }
        
        imageCollectionView.snp.makeConstraints {
            $0.leading.equalTo(addImageView.snp.trailing)
            $0.top.equalTo(addImageView)
            $0.height.equalTo(addImageView)
            $0.trailing.equalToSuperview()
        }
        
        contentTitleLabel.snp.makeConstraints {
            $0.top.equalTo(addImageView.snp.bottom).offset(20)
            $0.leading.equalToSuperview()
        }
        
        contentTextField.snp.makeConstraints {
            $0.top.equalTo(contentTitleLabel.snp.bottom).offset(10)
            $0.height.equalTo(safeAreaLayoutGuide).multipliedBy(0.2)
            $0.horizontalEdges.equalToSuperview()
        }
        
        saveButton.snp.makeConstraints {
            $0.top.equalTo(contentTextField.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.centerX.equalToSuperview()
            $0.height.equalTo(safeAreaLayoutGuide).multipliedBy(0.1)
        }
        
        needLogInLabel.snp.makeConstraints {
            $0.top.equalTo(mapView.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
        }
        
        finishButton.snp.makeConstraints {
            $0.top.equalTo(needLogInLabel.snp.bottom).offset(10)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.centerX.equalToSuperview()
            $0.height.equalTo(safeAreaLayoutGuide).multipliedBy(0.1)
        }
    }
}

extension SaveRecordRunningView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.frame.height
        return CGSize(width: height, height: height)
    }
}

extension SaveRecordRunningView: UICollectionViewDelegate {
}
