//
//  RecordViewController.swift
//  RunningCrew
//
//  Created by JunHwan Kim on 2023/03/01.
//

import UIKit
import RxSwift

class RecordViewController: BaseViewController {
    
    @IBOutlet weak var runningMeasuringView: UIView!
    @IBOutlet weak var readyDiscussionLabel: UILabel!
    @IBOutlet weak var readyTimerLabel: UILabel!
    @IBOutlet weak var pauseAndPlayButton: UIButton!
    @IBOutlet weak var completeButton: UIButton!
    @IBOutlet weak var completeButtonContainerView: UIView!
    @IBOutlet weak var runningTimerLabel: UILabel!
    @IBOutlet weak var runningDistanceLabel: UILabel!
    private var completeButtonRingLayer: CAShapeLayer?
    
    //MARK: - Properties
    private var readyTimer = Observable<Int>.timer(.seconds(1), period: .seconds(1), scheduler: MainScheduler.instance)
    private var viewModel: RecordViewModel
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //MARK: - Initalizer
    init(viewModel: RecordViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "RecordViewController", bundle: Bundle(for: RecordViewController.self))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - deinit
    deinit {
        viewModel.deinitViewModel()
        print("deinit record viewcontroller")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setView() {
        pauseAndPlayButton.layer.cornerRadius = pauseAndPlayButton.frame.height / 2
        completeButton.layer.cornerRadius = completeButton.frame.height / 2
        
        let trackLayer = CAShapeLayer()
        trackLayer.frame = completeButton.bounds
        completeButtonRingLayer = CAShapeLayer()
        guard let completeButtonRingLayer = completeButtonRingLayer else { return }
        completeButtonContainerView.layer.addSublayer(completeButtonRingLayer)
        completeButtonRingLayer.path = UIBezierPath(arcCenter: trackLayer.position, radius: completeButton.frame.width/2+2, startAngle: .pi * (3/2), endAngle: .pi * (7/2), clockwise: true).cgPath
        completeButtonRingLayer.strokeColor = UIColor.black.cgColor
        completeButtonRingLayer.lineWidth = 4
        completeButtonRingLayer.fillColor = UIColor.clear.cgColor
        completeButtonRingLayer.strokeEnd = 0
    }
    
    func showToastMessage() {
        print("show toast message ")
    }
  
    //MARK: - bind
    override func bind() {
        let input = RecordViewModel.Input(pauseAndPlayButtonDidTap: pauseAndPlayButton.rx.tap.asObservable())
        
        let output = viewModel.transform(input: input)
        
        output.isRunning
            .bind { isRunning in
                if isRunning {
                    self.pauseAndPlayButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
                } else {
                    self.pauseAndPlayButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
                }
            }
            .disposed(by: disposeBag)
        
        output.timerText
            .drive(runningTimerLabel.rx.text)
            .disposed(by: disposeBag)
        
        output.runningDistance
            .drive(runningDistanceLabel.rx.text)
            .disposed(by: disposeBag)
        
        
        readyTimer.take(5)
            .subscribe(onNext: { value in
                self.readyTimerLabel.text = String(4-value)
            }, onDisposed: {
                self.readyDiscussionLabel.isHidden = true
                self.readyTimerLabel.isHidden = true
                self.runningMeasuringView.isHidden = false
                self.viewModel.startTimer()
            })
            .disposed(by: disposeBag)
        
        completeButton.rx.controlEvent(.touchDown)
            .bind {
                Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false, block: {[weak self] timer in
                    let vc = SaveRecordRunningViewController()
                    vc.modalPresentationStyle = .fullScreen
                    self?.present(vc, animated: true)
                })
                
                let animation = CABasicAnimation(keyPath: "strokeEnd")
                animation.toValue = 1
                animation.duration = 2
                animation.isRemovedOnCompletion = false
                animation.fillMode = .forwards
                self.completeButtonRingLayer?.add(animation, forKey: "animation")
            }
            .disposed(by: disposeBag)
        
        completeButton.rx.controlEvent(.touchUpInside)
            .bind {
                self.completeButtonRingLayer?.removeAllAnimations()
                self.showToastMessage()
            }
            .disposed(by: disposeBag)
    }
}
