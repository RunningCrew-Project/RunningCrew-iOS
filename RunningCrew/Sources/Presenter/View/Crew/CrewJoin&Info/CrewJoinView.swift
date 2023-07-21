//
//  CrewJoinView.swift
//  RunningCrew
//
//  Created by Kim TaeSoo on 2023/05/05.
//

import UIKit

class CrewJoinView: UIView {
    let crewIconImageView: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.image = UIImage(systemName: "heart.fill")
        return image
    }()
    let crewNameLabel: UILabel = {
        let label = UILabel()
        label.text = "크루명"
        return label
    }()
    let crewCreateDate: UILabel = {
        let label = UILabel()
        label.text = "크루 생성 날짜 : 2023.02.02"
        return label
    }()
    lazy var topStackView: UIStackView = {
        let sv = UIStackView()
        sv.addArrangedSubview(crewNameLabel)
        sv.addArrangedSubview(crewCreateDate)
        sv.axis = .vertical
        sv.distribution = .equalSpacing
        sv.spacing = 12
        return sv
    }()
    let dividerView1: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray
        return view
    }()
    let regionLabel: UILabel = {
        let label = UILabel()
        label.text = "활동지역"
        return label
    }()
    let regionDetailLabel: UILabel = {
        let label = UILabel()
        label.text = "서울특별시 서초구"
        return label
    }()
    let dividerView2: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray
        return view
    }()
    let numberOfPeopleLabel: UILabel = {
        let label = UILabel()
        label.text = "크루 인원"
        return label
    }()
    let numberOfPeopleDetailLabel: UILabel = {
        let label = UILabel()
        label.text = "33명"
        return label
    }()
    let dividerView3: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray
        return view
    }()
    let crewLeaderLabel: UILabel = {
        let label = UILabel()
        label.text = "크루 리더"
        return label
    }()
    let crewLeaderDetailLabel: UILabel = {
        let label = UILabel()
        label.text = "김태수"
        return label
    }()
    let dividerView4: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray
        return view
    }()
    let crewIntroduceLabel: UILabel = {
        let label = UILabel()
        label.text = "크루 소개"
        return label
    }()
    let crewIntroduceDetailLabel: UILabel = {
        let label = UILabel()
        label.text = "크루소개 크루소개 크루소개 크루소개 크루소개 678크루소개 크루소개 크루소개 크루소개 크루소개123132 크루소개 크루소개 크루소개 크루소개 크루소개 크루소개 크루소개 크루소개"
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
     func setupUI() {
        [crewIconImageView, topStackView, dividerView1,
         regionLabel, regionDetailLabel, dividerView2,
         numberOfPeopleLabel, numberOfPeopleDetailLabel, dividerView3,
         crewLeaderLabel, crewLeaderDetailLabel, dividerView4,
         crewIntroduceLabel,crewIntroduceDetailLabel].forEach {self.addSubview($0)}
    }
     func makeConstraints() {
        let topLeading = 12
        crewIconImageView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(topLeading)
            make.leading.equalTo(safeAreaLayoutGuide).offset(topLeading)
            make.size.equalTo(48)
        }
        topStackView.snp.makeConstraints { make in
            make.leading.equalTo(crewIconImageView.snp.trailing).offset(topLeading)
            make.centerY.equalTo(crewIconImageView.snp.centerY)
        }
        dividerView1.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(topLeading)
            make.top.equalTo(crewIconImageView.snp.bottom).offset(topLeading)
        }
        regionLabel.snp.makeConstraints { make in
            make.top.equalTo(dividerView1.snp.bottom).offset(topLeading)
            make.leading.equalTo(safeAreaLayoutGuide).offset(topLeading)
        }
        regionDetailLabel.snp.makeConstraints { make in
            make.top.equalTo(regionLabel.snp.bottom).offset(4)
            make.leading.equalTo(safeAreaLayoutGuide).offset(topLeading)
        }
        dividerView2.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(topLeading)
            make.top.equalTo(regionDetailLabel.snp.bottom).offset(topLeading)
        }
        numberOfPeopleLabel.snp.makeConstraints { make in
            make.top.equalTo(dividerView2.snp.bottom).offset(topLeading)
            make.leading.equalTo(safeAreaLayoutGuide).offset(topLeading)
        }
        numberOfPeopleDetailLabel.snp.makeConstraints { make in
            make.top.equalTo(numberOfPeopleLabel.snp.bottom).offset(4)
            make.leading.equalTo(safeAreaLayoutGuide).offset(topLeading)
        }
        dividerView3.snp.makeConstraints { make in
            make.top.equalTo(numberOfPeopleDetailLabel.snp.bottom).offset(topLeading)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(topLeading)
            make.height.equalTo(1)
        }
        crewLeaderLabel.snp.makeConstraints { make in
            make.top.equalTo(dividerView3.snp.bottom).offset(topLeading)
            make.leading.equalTo(safeAreaLayoutGuide).offset(topLeading)
        }
        crewLeaderDetailLabel.snp.makeConstraints { make in
            make.top.equalTo(crewLeaderLabel.snp.bottom).offset(topLeading)
            make.leading.equalTo(safeAreaLayoutGuide).offset(topLeading)
        }
        dividerView4.snp.makeConstraints { make in
            make.top.equalTo(crewLeaderDetailLabel.snp.bottom).offset(topLeading)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(topLeading)
            make.height.equalTo(1)
        }
        crewIntroduceLabel.snp.makeConstraints { make in
            make.top.equalTo(dividerView4.snp.bottom).offset(topLeading)
            make.leading.equalTo(safeAreaLayoutGuide).offset(topLeading)
        }
        crewIntroduceDetailLabel.snp.makeConstraints { make in
            make.top.equalTo(crewIntroduceLabel.snp.bottom).offset(topLeading)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(topLeading)
        }
    }
}
