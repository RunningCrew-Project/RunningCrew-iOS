//
//  CrewJoinViewController.swift
//  RunningCrew
//
//  Created by Kim TaeSoo on 2023/05/05.
//

import UIKit

class CrewJoinViewController: UIViewController {
    let crewJoinView = CrewJoinView()
    override func loadView() {
        view = crewJoinView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
