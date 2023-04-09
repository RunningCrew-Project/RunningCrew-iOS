//
//  lightGray.swift
//  RunningCrew
//
//  Created by Dongwan Ryoo on 2023/04/09.
//

import UIKit
import FSCalendar

class MyPageClendarView: UIView {
    //MARK: - UI ProPerties
    
    
    private let dateFormatter: DateFormatter = {
           let formatter = DateFormatter()
           formatter.dateFormat = "yyyy-MM-dd"
           return formatter
       }()
    
    lazy var calendar: FSCalendar = {
        let view = FSCalendar(frame: CGRect(x: 0, y: 0, width: 320, height: 300))
        view.dataSource = self
        view.delegate = self
           return view
       }()
    
    //MARK: - Properties
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(calendar)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    //MARK: - Set UI
    
    func setCalendar() {
        calendar.scrollDirection = .horizontal
        calendar.backgroundColor = .white
        calendar.appearance.selectionColor = UIColor(named: "darkGreen")
        calendar.allowsMultipleSelection = false
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
        calendar.appearance.weekdayTextColor = .orange
        // 달력의 년월 글자 바꾸기
        calendar.appearance.headerDateFormat = "YYYY.M"
        // 달력의 요일 글자 바꾸는 방법 1
        calendar.locale = Locale(identifier: "ko_KR")
        // 년월에 흐릿하게 보이는 애들 없애기
        calendar.appearance.headerMinimumDissolvedAlpha = 0
    }
   
       
}

//MARK: - Define Method

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
            // 날짜 3개까지만 선택되도록
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

