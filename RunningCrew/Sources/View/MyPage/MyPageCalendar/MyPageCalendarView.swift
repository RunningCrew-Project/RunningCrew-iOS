//
//  lightGray.swift
//  RunningCrew
//
//  Created by Dongwan Ryoo on 2023/04/09.
//

import UIKit
import FSCalendar
import SnapKit

class MyPageClendarView: UIView {
    // MARK: - UI ProPerties
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    lazy var calendar: FSCalendar = {
        let view = FSCalendar(frame: CGRect(x: 0, y: 0, width: 337, height: 327))
        view.dataSource = self
        view.delegate = self
        
        return view
    }()
    
    lazy var prevButton:UIButton = {
        let button = UIButton()
        let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: 18, weight: .medium)
        button.setImage(UIImage(systemName: "chevron.left", withConfiguration: symbolConfiguration)?.withTintColor(.black, renderingMode: .alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(prevButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var nextButton:UIButton = {
        let button = UIButton()
        let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: 18, weight: .medium)
        button.setImage(UIImage(systemName: "chevron.right", withConfiguration: symbolConfiguration)?.withTintColor(.black, renderingMode: .alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        return button
    }()
    
    
    lazy var monthLabel:UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        
        return label
    }()
    
    lazy var monthStackView:UIStackView = {
        let stackveiw = UIStackView()
        stackveiw.alignment = .leading
        stackveiw.distribution = .equalCentering
        return stackveiw
        
    }()
    
    lazy var distanceLabel:UILabel = {
        let label = UILabel()
        label.text = "000.0"
        label.textColor = .black
        label.font = UIFont(name: "NotoSansKR-Bold", size: 48)
        
        return label
    }()
    
    lazy var kmLabel:UILabel = {
        let label = UILabel()
        label.text = "km"
        label.textColor = UIColor.darkGreen
        label.font = UIFont(name: "NotoSansKR-Bold", size: 20)
        label.textAlignment = .left
        
        return label
    }()
    
    lazy var timeLabel:UILabel = {
        let label = UILabel()
        label.text = "00:00:00"
        label.textColor = .black
        label.font = UIFont(name: "NotoSansKR-Bold", size: 30)
        
        return label
    }()
    
    lazy var runningStackView:UIStackView = {
        let stackveiw = UIStackView()
        stackveiw.alignment = .lastBaseline
        
        return stackveiw
        
    }()
    
    lazy var distanceKrLabel:UILabel = {
        let label = UILabel()
        label.text = "누적 거리"
        label.textColor = UIColor.darkGray
        label.font = UIFont(name: "NotoSansKR-Medium", size: 14)
        label.textAlignment = .left
        
        return label
    }()
    
    lazy var timeKrLabel:UILabel = {
        let label = UILabel()
        label.text = "누적 시간"
        label.textColor = UIColor.darkGray
        label.font = UIFont(name: "NotoSansKR-Medium", size: 14)
        label.textAlignment = .left
        
        return label
    }()
    
    lazy var krStackView: UIStackView = {
        let stackveiw = UIStackView()
        stackveiw.alignment = .leading
        
        return stackveiw
        
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.darkGray
        label.font = UIFont(name: "NotoSansKR-Medium", size: 14)
        label.textAlignment = .left
        
        let selectedDate = calendar.selectedDate ?? Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년 MM월 dd일 EEEE"
        let dateString = dateFormatter.string(from: selectedDate)
        label.text = dateString
        
        return label
    }()

    
    //MARK: - Properties
    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
        setConstraint()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Set UI
    
    func setView() {
        self.addSubview(calendar)
        self.backgroundColor = .white
        setmonthStackView()
        setrunningStackView()
        setKrStackView()
        setCalendar()
        self.addSubview(dateLabel)
    }
    
    func setConstraint(){
        viewConstraint()
        calendarConstraint()
        monthStackViewConstraint()
        monthLabelConstraint()
        runningStackViewConstraint()
        distanceLabelConstraint()
        krStackViewConstraint()
        distanceKrLabelConstraint()
        dateLabelConstraint()
    }
    
    func setmonthStackView() {
        self.addSubview(monthStackView)
        monthStackView.addArrangedSubview(prevButton)
        monthStackView.addArrangedSubview(monthLabel)
        monthStackView.addArrangedSubview(nextButton)
    }
    
    func setrunningStackView() {
        self.addSubview(runningStackView)
        runningStackView.addArrangedSubview(distanceLabel)
        runningStackView.addArrangedSubview(kmLabel)
        runningStackView.addArrangedSubview(timeLabel)
    }
    
    func setKrStackView() {
        self.addSubview(krStackView)
        krStackView.addArrangedSubview(distanceKrLabel)
        krStackView.addArrangedSubview(timeKrLabel)
        
    }
    
    func setCalendar() {
        calendar.scrollDirection = .horizontal
        calendar.backgroundColor = UIColor.lightGray
        calendar.layer.cornerRadius = 10
        calendar.appearance.todayColor = UIColor.darkGreen
        //날짜 선택 시 색 변경
        calendar.appearance.selectionColor = UIColor.lightGreen
        // 다중 선택 가능
        calendar.allowsMultipleSelection = true
        // 스와이프 스크롤 작동 여부 ( 활성화하면 좌측 우측 상단에 다음달 살짝 보임, 비활성화하면 사라짐 )
        calendar.scrollEnabled = true
        // 스와이프 스크롤 방향 ( 버티칼로 스와이프 설정하면 좌측 우측 상단 다음달 표시 없어짐, 호리젠탈은 보임 )
        calendar.scrollDirection = .horizontal
        // 선택된 날짜의 모서리 설정 ( 0으로 하면 사각형으로 표시 )
        calendar.appearance.borderRadius = 50
        // 타이틀 컬러
        calendar.appearance.titleSelectionColor = .black
        // 서브 타이틀 컬러
        calendar.appearance.subtitleSelectionColor = .black
        // 달력의 평일 날짜 색깔
        calendar.appearance.titleDefaultColor = .black
        // 달력의 토,일 날짜 색깔
        calendar.appearance.titleWeekendColor = .black
        // 달력의 맨 위의 년도, 월의 색깔
        calendar.appearance.headerTitleColor = .black
        // 달력의 요일 글자 색깔
        calendar.appearance.weekdayTextColor = UIColor.darkGreen
        
        // 헤더 삭제
        calendar.headerHeight = 0
        
        // 달력의 요일 글자 바꾸는 방법 1
        calendar.locale = Locale(identifier: "ko_KR")
        // 년월에 흐릿하게 보이는 애들 없애기
        calendar.appearance.headerMinimumDissolvedAlpha = 0
        
        
    }
    
    func viewConstraint() {
        self.snp.makeConstraints { make in
            make.width.equalTo(calendar.fs_width)
            make.height.equalTo(425)
        }
    }

    func calendarConstraint() {
        calendar.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(130)
            make.leading.equalTo(self.snp.leading)
            make.trailing.equalTo(self.snp.trailing)
            make.bottom.equalTo(self.snp.bottom)
        }
    }
    
    func monthStackViewConstraint() {
        monthStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.snp.top).offset(13)

        }
    }
    
    func monthLabelConstraint() {
        monthLabel.snp.makeConstraints { make in
            make.width.equalTo(119)

        }
    }
    
    func runningStackViewConstraint() {
        runningStackView.snp.makeConstraints { make in
            make.top.equalTo(monthStackView.snp.bottom)
            make.centerX.equalToSuperview()
            make.width.equalTo(calendar.snp.width)
            make.height.equalTo(72)

        }
    }
    
    func distanceLabelConstraint() {
        distanceLabel.snp.makeConstraints { make in
            make.width.equalTo(134)

        }
    }
    
    func krStackViewConstraint() {
        krStackView.snp.makeConstraints { make in
            make.top.equalTo(runningStackView.snp.bottom)
            make.bottom.equalTo(calendar.snp.top).offset(-10)
        }
    }
    
    func distanceKrLabelConstraint() {
        distanceKrLabel.snp.makeConstraints { make in
            make.width.equalTo(211)
        }
    }
    
    func dateLabelConstraint() {
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(calendar.snp.bottom).offset(10)
        }
    }
    
    
    @objc func nextButtonTapped() {
        let currentPage = calendar.currentPage
        let nextMonth = currentPage.addingMonths(1)
        calendar.setCurrentPage(nextMonth!, animated: true)
    }
    
    @objc func prevButtonTapped() {
        let currentPage = calendar.currentPage
        let previousMonth = currentPage.addingMonths(-1)
        calendar.setCurrentPage(previousMonth!, animated: true)
    }
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        updateMonthLabel()
    }
    
    func updateMonthLabel() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월"
        monthLabel.text = formatter.string(from: calendar.currentPage)
    }
    
}


//MARK: - Define Method


// 페이지 전환하는 메서드
extension Date {
    func addingMonths(_ months: Int) -> Date? {
        let calendar = Calendar.current
        var components = DateComponents()
        components.month = months
        return calendar.date(byAdding: components, to: self)
    }
}

extension MyPageClendarView : FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    
    // 날짜 선택 시 콜백 메소드
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print(dateFormatter.string(from: date) + " 선택됨")
    }
    
    // 날짜 선택 해제 시 콜백 메소드
    public func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print(dateFormatter.string(from: date) + " 해제됨")
    }
    
    //최대 선택 가능 갯수
    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
        // 날짜 30개까지만 선택되도록
        if calendar.selectedDates.count > 30 {
            return false
        } else {
            return true
        }
    }
    
    //선택해제
    func calendar(_ calendar: FSCalendar, shouldDeselect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
        return true // 선택해제 가능
    }
    
    
}

