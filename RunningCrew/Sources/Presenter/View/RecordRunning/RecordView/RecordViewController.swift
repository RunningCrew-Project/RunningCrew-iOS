//
//  RecordViewController.swift
//  RunningCrew
//
//  Created by JunHwan Kim on 2023/03/01.
//

import UIKit
import RxSwift

protocol RecordViewDelegate: AnyObject {
    func finishRunning(path: [(Double, Double)])
}

final class RecordViewController: BaseViewController {
    
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
    weak var delegate: RecordViewDelegate?
    private var viewModel: RecordViewModel
    private let motionManager = MotionManager.shared
    private var timer = Observable<Int>.timer(.seconds(1), period: .seconds(1), scheduler: MainScheduler.instance)
    
    init(viewModel: RecordViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
    }
  
    override func bind() {
        let pauseAndPlayButtonDidTap = pauseAndPlayButton.rx.tap.asObservable()
        
        let input = RecordViewModel.Input(pauseAndPlayButtonDidTap: pauseAndPlayButtonDidTap)
        
        let output = viewModel.transform(input: input)
        
        output.isRunning
            .bind { isRunning in
                let imageName = isRunning ? "pause.fill" : "play.fill"
                self.pauseAndPlayButton.setImage(UIImage(systemName: imageName), for: .normal)
            }
            .disposed(by: disposeBag)
        
        output.timerText
            .drive(runningTimerLabel.rx.text)
            .disposed(by: disposeBag)
        
        output.runningDistance
            .drive(runningDistanceLabel.rx.text)
            .disposed(by: disposeBag)
        
        timer.take(5)
            .subscribe(onNext: { value in
                self.readyTimerLabel.text = String(4-value)
            }, onDisposed: {
                self.readyDiscussionLabel.isHidden = true
                self.readyTimerLabel.isHidden = true
                self.runningMeasuringView.isHidden = false
                self.viewModel.startRunning()
            })
            .disposed(by: disposeBag)
        
        completeButton.rx.controlEvent(.touchDown)
            .subscribe(onNext: { [weak self] in
                self?.completeButtonDidTouchTown()
            })
            .disposed(by: disposeBag)
        
        completeButton.rx.controlEvent(.touchDown)
            .flatMapLatest { _ -> Observable<Int> in
                return Observable<Int>.timer(.seconds(2), scheduler: ConcurrentMainScheduler.instance)
                    .take(until: self.completeButton.rx.controlEvent([.touchUpInside, .touchUpOutside]))
            }
            .subscribe { [weak self] _ in
                self?.delegate?.finishRunning(path: self?.viewModel.pathInformation() ?? [])
            }
            .disposed(by: disposeBag)
        
        completeButton.rx.controlEvent([.touchUpInside, .touchUpOutside])
            .bind { [weak self] _ in
                self?.completeButtonRingLayer?.removeAllAnimations()
                self?.showToastMessage()
            }
            .disposed(by: disposeBag)
    }
}

extension RecordViewController {
    private func completeButtonDidTouchTown() {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.toValue = 1
        animation.duration = 2
        animation.isRemovedOnCompletion = false
        animation.fillMode = .forwards
        self.completeButtonRingLayer?.add(animation, forKey: "animation")
    }
    
    private func setView() {
        pauseAndPlayButton.layer.cornerRadius = pauseAndPlayButton.frame.height / 2
        completeButton.layer.cornerRadius = completeButton.frame.height / 2
        
        let trackLayer = CAShapeLayer()
        trackLayer.frame = completeButton.bounds
        
        completeButtonRingLayer = CAShapeLayer()
        guard let completeButtonRingLayer = completeButtonRingLayer else { return }
        completeButtonContainerView.layer.addSublayer(completeButtonRingLayer)
        
        completeButtonRingLayer.strokeColor = UIColor.black.cgColor
        completeButtonRingLayer.lineWidth = 4
        completeButtonRingLayer.fillColor = UIColor.clear.cgColor
        completeButtonRingLayer.strokeEnd = 0
        completeButtonRingLayer.path = UIBezierPath(arcCenter: trackLayer.position,
                                                    radius: completeButton.frame.width/2+2,
                                                    startAngle: .pi * (3/2),
                                                    endAngle: .pi * (7/2),
                                                    clockwise: true).cgPath
    }
    
    private func showToastMessage() {
        //TODO: 토스트 메시지
    }
}
