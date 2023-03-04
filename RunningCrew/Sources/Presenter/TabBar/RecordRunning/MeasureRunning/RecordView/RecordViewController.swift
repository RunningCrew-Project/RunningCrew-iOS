//
//  RecordViewController.swift
//  RunningCrew
//
//  Created by JunHwan Kim on 2023/03/01.
//

import UIKit
import RxSwift

class RecordViewController: UIViewController {
    
    @IBOutlet weak var runningMeasuringView: UIView!
    @IBOutlet weak var readyDiscussionLabel: UILabel!
    @IBOutlet weak var readyTimerLabel: UILabel!
    @IBOutlet weak var pauseAndPlayButton: UIButton!
    @IBOutlet weak var completeButton: UIButton!
    @IBOutlet weak var runningTimerLabel: UILabel!
    
    //MARK: - Properties
    private var timer: Timer?
    private var readyTimerNum = 5
    var viewModel: RecordViewModel?
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        runningMeasuringView.isHidden = true
        setControlButtonCornerRadius()
        startReadyTimer()
        bind()
    }
    
    //MARK: - Initalizer
    init(viewModel: RecordViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "RecordViewController", bundle: Bundle(for: RecordViewController.self))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Ready Time Method
    private func startReadyTimer() {
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(readyTimerCallBack), userInfo: nil, repeats: true)
    }
    
    @objc func readyTimerCallBack() {
        readyTimerNum -= 1
        if readyTimerNum == 0 {
            timer?.invalidate()
            timer = nil
            hiddenTimerLabel()
            runningMeasuringView.isHidden = false
            viewModel?.startTimer()
        }
        readyTimerLabel.text = String(readyTimerNum)
    }
    
    //MARK: - Set UI Constraint
    private func setControlButtonCornerRadius() {
        pauseAndPlayButton.layer.cornerRadius = pauseAndPlayButton.frame.height / 2
        pauseAndPlayButton.clipsToBounds = true
        
        completeButton.layer.cornerRadius = completeButton.frame.height / 2
        completeButton.clipsToBounds = true
    }
    
    private func hiddenTimerLabel() {
        readyDiscussionLabel.isHidden = true
        readyTimerLabel.isHidden = true
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //MARK: - bind
    private func bind() {
        viewModel?.timerText.asDriver()
            .drive(runningTimerLabel.rx
                .text)
            .disposed(by: disposeBag)
    }
    
    //MARK: - Action Method

    @IBAction func tapPauseOrPlayButton(_ sender: Any) {
        guard let viewModel = viewModel else { return }
        if viewModel.isRunning {
            pauseAndPlayButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
            viewModel.stopTimer()
        } else {
            pauseAndPlayButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
            viewModel.startTimer()
        }
    }
    
    //MARK: - deinit
    deinit {
        print("deinit record viewcontroller")
    }
}
