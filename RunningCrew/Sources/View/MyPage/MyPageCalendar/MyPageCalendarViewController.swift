//
//  MyPageCalendarViewController.swift
//  RunningCrew
//
//  Created by Dongwan Ryoo on 2023/04/09.
//

import UIKit
import SnapKit

final class MyPageCalendarViewController: BaseViewController {
        
    private var myCalendarView: MyPageCalendarView!

    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.myCalendarView = MyPageCalendarView()
        self.view = myCalendarView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
