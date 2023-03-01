//
//  RecordViewController.swift
//  RunningCrew
//
//  Created by JunHwan Kim on 2023/03/01.
//

import UIKit

class RecordViewController: UIViewController {
    
    @IBOutlet weak var runningMeasuringView: UIView!
    @IBOutlet weak var readyDiscussionLabel: UILabel!
    @IBOutlet weak var readyTimerLabel: UILabel!
    @IBOutlet weak var pauseAndPlayButton: UIButton!
    @IBOutlet weak var completeButton: UIButton!
    
    //MARK: - Properties
    private var timer: Timer?
    private var readyTimerNum = 5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        runningMeasuringView.isHidden = true
        setControlButtonCornerRadius()
        startReadyTimer()
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
        }
        readyTimerLabel.text = String(readyTimerNum)
    }
    
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
    
    deinit {
        print("deinit record viewcontroller")
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
