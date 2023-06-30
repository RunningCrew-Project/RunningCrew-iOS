//
//  CrewGenerateFinishView.swift
//  RunningCrew
//
//  Created by Kim TaeSoo on 2023/05/05.
//

import UIKit
import SnapKit

class CrewGenerateFinishView: BaseView {
    let closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .black
        return button
    }()
    let mainLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 4
        label.textAlignment = .center
        label.text = "크루가 생성되었습니다.\n\n크루원들을 모아\n함께 달려보세요!"
        label.font = UIFont(name: "NotoSansKR-Bold", size: 26)
        return label
    }()
    let showCrewButton: UIButton = {
        let button = UIButton()
        button.setTitle("크루 보러 가기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "NotoSansKR-Bold", size: 24)
        button.backgroundColor = .darkGreen
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        return button
    }()
   
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    override func setupUI() {
        [closeButton, mainLabel, showCrewButton].forEach { self.addSubview($0) }
    }
    override func makeConstraints() {
        let topLeading = 16
        closeButton.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(topLeading)
            make.leading.equalTo(safeAreaLayoutGuide).offset(topLeading)
        }
        mainLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(68)
            make.top.equalTo(safeAreaLayoutGuide).offset(100)
        }
        showCrewButton.snp.makeConstraints { make in
            make.bottom.equalTo(keyboardLayoutGuide.snp.top)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(topLeading)
            make.height.equalTo(52)
        }
    }
}
